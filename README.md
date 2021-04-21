# CS-UY 3224 class VM spring 2021

## Setup 

- install [Vagrant](https://www.vagrantup.com/)
- clone this repo
- run `vagrant up` to build then start vm (this may take a while as it installs lots of stuff)
- run `vagrant ssh` to access vm

## Configuration

You may want to consider the amount of resources alloted to this VM. 
You can change the number of cores, and memory size in the [Vagrantfile](./Vagrantfile).

## Shared files

Vagrant adds `/vagrant` in the vm to be the shared directory that the Vagrantfile lives in.
If you would like your files to exist in both the vm and your host, put them there.
