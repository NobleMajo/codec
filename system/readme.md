# CodeC
- [CodeC](#codec)
- [About](#about)
- [Warning](#warning)
  - [Warning for Compute/Software/Hosting](#warning-for-computesoftwarehosting)
  - [Warning for Storage/Cloud/Database](#warning-for-storageclouddatabase)
- [Ecosystem](#ecosystem)
  - [Container](#container)
  - [Breakout](#breakout)
- [Persistent data](#persistent-data)
  - [Software](#software)
  - [Data](#data)
  - [Benefits](#benefits)
- [Features](#features)
  - [Mods](#mods)
  - [Mounts](#mounts)
  - [Docker](#docker)
  - [Systemd](#systemd)
  - [Commands](#commands)
    - [Examples](#examples)
  - [Custom commands](#custom-commands)
      - [Command examples:](#command-examples)

# About
Codec is a `visual studio code` docker container designed for development from anywhere `from any web browser` with some additional development features.

# Warning
Codec is not a server hosting or cloud service.

## Warning for Compute/Software/Hosting
It is allowed to use software on the released ports ("/codec/.codec/ports.into.txt").

Other software may not be run for more than 8 hours without an interruption of at least half of the runtime.
That means a break of at least 4 hours after 8 hours, a break of at least 3 hours after 6 hours and a break of at least 1 hour after 2 hours.

## Warning for Storage/Cloud/Database
Also its not allowed to use codec as place to store data.
Please try not to use more than 1 GB.
if you exceed this limit, we will contact you before we delete anything. 

If the container uses more than 4 GB, we may look into the container's data and delete folders and files without asking and warning again.

# Ecosystem

## Container
Codec runs inside a linux container. this is something like a virtual machine.

## Breakout
Breaking out of this container is prevented by mechanisms, but is still not permitted.

# Persistent data
Codec can only store data in the `/codec` folder.
Data saved outside of this folder will not be saved after a codec restart.

If a mysql database is installed and the data folder is not in `/codec`, the DBMS and  the database is deleted after a restart of the codec container.

If software and its data needs to be stored persistently, then follow the [Software](#Software) and [Data](#Data) steps.

## Software
No software should be installed in the `/codec` folder.
Software should be installed either through the `/codec/.codec/boot.sh` bash script or through a codec Mod.
Codec Mods are explained in [Mods](#mods) below.

## Data
Any software data such as databases, configurations and custom-source-code should be stored somewhere in the `/codec` directory.
Excluded from this is any software available online on the internet and also its source code.

## Benefits
Following the `Persistent data` rules has several benefits for both user and codec host.

Because only data is stored in the `/codec` folder, restoring, starting, moving and backing up a codec container is quick and easy.

In the event of an error or if software is no longer required, the software can be removed immediately and completely by restarting the container.

All data that is stored persistently is determined by the user and not by the software.

# Features

## Mods
Software should be installed either through the `/codec/.codec/boot.sh` bash script or through a Mod in the `/codec/.codec/enabled-mods` folder.
There are already some Mods in the `/codec/.codec/mods` folder as a template for your own Mods.
with the command `codec modon` you can switch Mods on and with `codec modoff` you can switch them off.

## Mounts
This `/codec/.codec/mounts.json` mounts configuration exists to persist folders that are distributed on the system.
The key-value object in this json file uses as a key the file or folder which is located under `/codec/mounts/${KEY}` and the folder which should be linked there.
Because the link points to `/codec/mounts/*`, all data will be stored permanently because they are located in the `/codec` folder.

## Docker
The codec docker image supports `dind` ("Docker in Docker"), which means `docker can be used` within the codec container if the host wants to support it.

Use `codec modon docker` to enable dockerd.

## Systemd
The first thing the codec container starts is systemd.

Systemd is a software suite that provides an array of system components for Linux operating systems.
Its main aim is to unify service configuration and behavior across Linux distributions.

Systemd manages some services like `vscode-server`, `docker` services and also the own `codec service` which are important for the codec ecosystem.

## Commands
Codec comes with some of its own commands which make it easier to use codec and can change some settings.
An example is the `codec` command which you should test with `codec --help`.
### Examples
 - codec (codec main command)
 - code (vscode code command)
 - codeclogs (shows codec service logs)

## Custom commands
Codec allows you to place your own commands in the `/codec/.codec/bin` folder.
These can then be used in the command line.

There are already some helpful commands that are not required for the codec ecosystem.
#### Command examples:
 - aptup (apt system update, upgrade, autoremove and clean up)
 - gin (shows curren git branche and file changes)
 - gundo (shows and undo the last commit if you press enter)
 - eclean (can free some disk space in emergency)

[Back to top](#codec)