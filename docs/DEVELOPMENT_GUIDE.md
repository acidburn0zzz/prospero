# Development Guide

#### 0. Pre-requisites

- Install [Git](https://git-scm.com/downloads)
- Install [Vagrant](https://www.vagrantup.com/downloads.html)
- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Have internet connection during the entire process

#### 1. Checkout source code

Open your terminal to write the following commands:
```sh
git clone https://framagit.org/lobster/prospero.git
```

#### 2. Start the development environment

```sh
cd prospero
vagrant up
```

This command does the following:

- creates the virtual machine from the base Ubuntu 18.04 image
- installs system requirements
- runs and configures external services
- installs Prospéro dependencies
- creates and initialize database

The first time it may take a while.

With any problems, to continue use:
```sh
vagrant provide
```



#### 3. Connect to the development environment

Once the development environment has started, connect to it with SSH:

```sh
vagrant ssh
```

You should see output that starts like this:

```
Welcome to Ubuntu 18.04.3 LTS (GNU/Linux 4.15.0-70-generic x86_64)
.
.
.
vagrant@ubuntu-bionic:/srv/prospero$
```

#### 4. Run tests

```sh
rails test
```

#### 5. Run Prospéro

Run Prospéro as services defined in Procfile.
```sh
foreman start
```

Open your browser at `http://localhost:3000`

You should see on browser the "Yay! You’re on Rails!" like this image: ![Yay! You’re on Rails!](rails-online.png)

#### 6. Stop Prospéro

At the terminal
```sh
Use Ctrl-C to stop
```