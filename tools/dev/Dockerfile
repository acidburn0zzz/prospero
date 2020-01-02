# Inspired from https://github.com/zulip/zulip/blob/5c734f70486daaa2a72a284471d08052c633b1f6/tools/setup/dev-vagrant-docker/Dockerfile

FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt --yes update

RUN apt install --yes gnupg2 curl

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt --yes update
RUN apt --yes upgrade

RUN apt install --no-install-recommends -y \
           ca-certificates \
           curl \
           locales \
           lsb-release \
           openssh-server \
           python3 \
           sudo \
           libpq-dev \
           yarn \
           nodejs \
           systemd \
           postgresql-12 \
           postgresql-contrib-12 \
           redis-server

ARG VAGRANT_UID

RUN \
    # We use https://github.com/gdraheim/docker-systemctl-replacement
    # to make services we install like postgres, redis, etc. normally
    # managed by systemd start within Docker, which breaks normal
    # operation of systemd.
    dpkg-divert --add --rename /bin/systemctl \
    && curl -so /bin/systemctl 'https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/73b5aff2ba6abfd254d236f1df22ff4971d44660/files/docker/systemctl3.py' \
    && chmod +x /bin/systemctl \
    && ln -nsf /bin/true /usr/sbin/policy-rc.d \
    && mkdir -p /run/sshd \
    # docker-systemctl-replacement doesn’t work with template units yet:
    # https://github.com/gdraheim/docker-systemctl-replacement/issues/62
    && ln -ns /lib/systemd/system/postgresql@.service /etc/systemd/system/multi-user.target.wants/postgresql@12-main.service \
    # redis fails to start with the default configuration if IPv6 is disabled:
    # https://github.com/antirez/redis/pull/5598
    && dpkg-divert --add --rename /etc/default/redis-server \
    && printf 'ULIMIT=65536\nDAEMON_ARGS="/etc/redis/redis.conf --bind 127.0.0.1"\n' > /etc/default/redis-server \
    && mkdir /etc/systemd/system/redis-server.service.d \
    && printf '[Service]\nExecStart=\nExecStart=/usr/bin/redis-server /etc/redis/redis.conf --bind 127.0.0.1\n' > /etc/systemd/system/redis-server.service.d/override.conf \
    # Set up the vagrant user and its SSH key (globally public)
    && useradd -ms /bin/bash -u "$VAGRANT_UID" vagrant \
    && mkdir -m 700 ~vagrant/.ssh \
    && curl -so ~vagrant/.ssh/authorized_keys 'https://raw.githubusercontent.com/hashicorp/vagrant/be7876d83644aa6bdf7f951592fdc681506bcbe6/keys/vagrant.pub' \
    && chown -R vagrant: ~vagrant/.ssh \
    && echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vagrant

RUN su vagrant -c "gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
RUN su vagrant -c "curl -sSL https://get.rvm.io | bash -s stable"
RUN su vagrant -c "/home/vagrant/.rvm/bin/rvm install ruby-2.6.5"

RUN ln -nsf /srv/prospero /home/vagrant/prospero
RUN echo "cd /srv/prospero" >> /home/vagrant/.profile

CMD ["/bin/systemctl"]

EXPOSE 22
EXPOSE 5000
