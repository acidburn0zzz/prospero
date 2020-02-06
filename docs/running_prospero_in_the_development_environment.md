# Running Prospéro in the development environment

#### 0. Pre-requisites

- Install the latest version of [Vagrant](https://www.vagrantup.com/downloads.html)
- Install the latest version of [Docker](https://docs.docker.com/install/)
  - Windows installer: https://download.docker.com/win/stable/Docker%20Desktop%20Installer.exe
  - Mac installer: https://download.docker.com/mac/stable/Docker.dmg

#### 1. Start the development environment

You must have a stable internet connection during the entire process.

_**on Windows** you must open the command prompt **as administrator**._

```sh
cd prospero
vagrant up
```

You should see output that looks like this in your terminal:

```
Bringing machine 'default' up with 'docker' provider...
.
.
.
default: Database initialized.
```

This command does the following:

- creates the virtual machine from the base Ubuntu 18.04 image
- installs system requirements
- runs and configures external services
- installs Prospéro dependencies
- creates and initializes Prospéro database

The first time it may take a while.

If it is not the first time, you need to update all dependencies by running:

```sh
vagrant provision
```

#### 2. Connect to the development environment

Once the development environment has started, connect to it with SSH:

```sh
vagrant ssh
```

You should see output that looks like this in your terminal:

```
Welcome to Ubuntu 18.04.3 LTS (GNU/Linux 4.15.0-70-generic x86_64)
.
.
.
vagrant@4b01633b6ac8:/srv/prospero
```

#### 3. Launch Prospéro

_From the development environment at `/srv/prospero`_

Start Prospéro processes using [Foreman](https://ddollar.github.io/foreman/).

```sh
foreman start
```

You should see output that looks like this in your terminal:

```
09:42:41 web.1    | started with pid 25760
09:42:41 worker.1 | started with pid 25761
09:42:42 web.1    | [25760] Puma starting in cluster mode...
09:42:42 web.1    | [25760] * Version 4.3.0 (ruby 2.6.5-p114), codename: Mysterious Traveller
09:42:42 web.1    | [25760] * Min threads: 5, max threads: 5
09:42:42 web.1    | [25760] * Environment: development
09:42:42 web.1    | [25760] * Process workers: 2
09:42:42 web.1    | [25760] * Phased restart available
09:42:42 web.1    | [25760] * Listening on tcp://0.0.0.0:5000
09:42:42 web.1    | [25760] Use Ctrl-C to stop
09:42:56 web.1    | [25760] - Worker 0 (pid: 25764) booted, phase: 0
09:42:58 web.1    | [25760] - Worker 1 (pid: 25765) booted, phase: 0
09:42:58 worker.1 | 2019-11-29T09:42:58.685Z pid=25761 tid=gocxv22tt INFO: Running in ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-linux]
09:42:58 worker.1 | 2019-11-29T09:42:58.685Z pid=25761 tid=gocxv22tt INFO: See LICENSE and the LGPL-3.0 for licensing details.
09:42:58 worker.1 | 2019-11-29T09:42:58.685Z pid=25761 tid=gocxv22tt INFO: Upgrade to Sidekiq Pro for more features and support: http://sidekiq.org
09:42:58 worker.1 | 2019-11-29T09:42:58.685Z pid=25761 tid=gocxv22tt INFO: Booting Sidekiq 6.0.3 with redis options {:id=>"Sidekiq-server-PID-25761", :url=>nil}
```

Open your browser at http://localhost:5000

You should land on Prospéro home page:

![Prospéro home](prospero-home.png)

#### 4. Stop Prospéro

```sh
Use Ctrl-C to stop
```

You should see something like this:
```
08:32:42 web.1    | exited with code 0
08:32:44 worker.1 | exited with code 0
```

To quit the development environment run:
```sh
exit
```

#### Other actions

##### Validate code-style

Check for code-style offenses with [Rubocop](https://www.rubocop.org)

_From the development environment at `/srv/prospero`_

```sh
rubocop
```

##### Run tests

Run automate tests with [RSpec](https://rspec.info/).

_From the development environment at `/srv/prospero`_

```sh
rspec
```

## See also

- [Development workflow](development_workflow.md)
