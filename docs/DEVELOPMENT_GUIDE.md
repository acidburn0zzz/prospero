# Development Guide

#### 0. Pre-requisites

- Install [Git](https://git-scm.com/downloads)
- Install [Vagrant](https://www.vagrantup.com/downloads.html)
- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Have internet connection during the entire process

#### 1. Checkout source code

```sh
~$ git clone https://framagit.org/lobster/prospero.git
```

#### 2. Start the development environment

```sh
~$ cd prospero
~/prospero$ vagrant up
```

This command does the following:

- creates the virtual machine from the base Ubuntu 18.04 image
- installs system requirements
- runs and configures external services
- installs Prospéro dependencies
- creates and initialize database

The first time it may take a while.

#### 3. Connect to the development environment

Once the development environment has started, connect to it with SSH:

```sh
~/prospero$ vagrant ssh
```

You should see output that starts like this:

```
Welcome to Ubuntu 18.04.3 LTS (GNU/Linux 4.15.0-70-generic x86_64)
```

#### 4. Run tests

```sh
vagrant@ubuntu-bionic:/srv/prospero$ rails test
```

#### 5. Run Prospéro

```sh
vagrant@ubuntu-bionic:/srv/prospero$ foreman start
```

Open your browser at `http://localhost:3000`
