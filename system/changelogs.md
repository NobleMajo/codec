- [About](#about)
- [CodeC 2](#codec-2)
  - [Apr 6, 2023](#apr-6-2023)
  - [Mar 23, 2023](#mar-23-2023)
  - [Mar 22, 2023](#mar-22-2023)
  - [Mar 9, 2023](#mar-9-2023)
  - [Mar 1, 2023](#mar-1-2023)
  - [Feb 20, 2023](#feb-20-2023)
  - [Jan 10, 2023](#jan-10-2023)
  - [Jan 4, 2023](#jan-4-2023)
  - [Dec 29, 2022](#dec-29-2022)
  - [Dec 14, 2022](#dec-14-2022)
  - [Dec 13, 2022](#dec-13-2022)
  - [Nov 18, 2022](#nov-18-2022)
  - [Nov 17, 2022](#nov-17-2022)
  - [Oct 1, 2022](#oct-1-2022)
  - [Sep 28, 2022](#sep-28-2022)
  - [Sep 25, 2022](#sep-25-2022)
  - [Sep 11, 2022](#sep-11-2022)
  - [Sep 7, 2022](#sep-7-2022)
  - [Sep 5, 2022](#sep-5-2022)
  - [Sep 4, 2022](#sep-4-2022)
  - [Sep 4, 2022](#sep-4-2022-1)
  - [Sep 2, 2022](#sep-2-2022)
- [Codec](#codec)
  - [May 3, 2022](#may-3-2022)
  - [May 2, 2022](#may-2-2022)
  - [Apr 1, 2022](#apr-1-2022)
  - [Mar 25, 2022](#mar-25-2022)
  - [Mar 4, 2022](#mar-4-2022)
  - [Mar 1, 2022](#mar-1-2022)
  - [Feb 24, 2022](#feb-24-2022)
  - [Feb 22, 2022](#feb-22-2022)
  - [Feb 21, 2022](#feb-21-2022)
  - [Feb 14, 2022](#feb-14-2022)

# About
CodeC is a containerized web-browser code-server development environment.
Code-Server is a vs-code abstraction build by Coder (GitHub: coder/code-server).

# CodeC 2
Changes of the version v2.0.0 (1. reversion) of CodeC.
First version with big breaking changes, new folder structure, build in systemd and other breaking features. 

## Apr 6, 2023
- Fix typo in readme
- Update code-server version
- Docs update
## Mar 23, 2023
- Update majo link on login screen
## Mar 22, 2023
- Modify codec boot scripts and default mods
## Mar 9, 2023
- Update Code Server version

## Mar 1, 2023
- Rename majo418 to noblemajo

## Feb 20, 2023
- Fix commands

## Jan 10, 2023
- Update dependencies version

## Jan 4, 2023
- Fix in start script if no port is defined

## Dec 29, 2022
- Fix cpasshash cmd
- Improve start output and cron update cmd

## Dec 14, 2022
- Fix stopall and disable cmd
- Improve enable and disable cmd
- Add enable and disable cmd

## Dec 13, 2022
- Fix stopall cmd
- Change Codec net name

## Nov 18, 2022
- Fix cron cmd and update all
- Add cron restart feature

## Nov 17, 2022
- Merge main and local
- Add unfinished cron and uncron script
- Fix test pipeline
- Use latest code-server version to build

## Oct 1, 2022
- Provider CLI tools, KEL scripts, and fix mod system

## Sep 28, 2022
- Fix login SVG and password label
- Provider scripts and login page

## Sep 25, 2022
- Add CodecCLI feature to cache user ports
- Change Code Server version and disable README feature

## Sep 11, 2022
- Change error message padding

## Sep 7, 2022
- Repair example mods and repair mod system

## Sep 5, 2022
- Fix container crash on set password
- Improve CodecCLI install and uninstall command
- Improve login, build time, and start time
- Improve exist and start CodecCLI cmd
- Run CodecCLI as root
- Add nice custom login page
- Improve input

## Sep 4, 2022
- Add: own login screen

## Sep 4, 2022
- Change: add env to mod system

## Sep 2, 2022
- Change: improve custom cmds
- Change: improve codec cli tool
- Implement codec v2


# Codec
Changes of the first development and release versions CodeC.

## May 3, 2022
- Add: gundo and cd commands
- Change: improve codec log command
- Change: improve codec and allow cli scripts
- Change: remove dockerfile layers
- Fix: codec -fr command

## May 2, 2022
- Add: codecdd as codec docker deamon cli tool
- Add: myip cli tool
- Add: new codec cli tool
- Change: small changes

## Apr 1, 2022
- Change: update readme

## Mar 25, 2022
- Change: update git ignore

## Mar 4, 2022
- Change: run with installed node version

## Mar 1, 2022
- Change: increase container test limits
- Change: update readme
- Add: quitAll.sh

## Feb 24, 2022
- Fix: extensions don't install on boot

## Feb 22, 2022
- Change: run extensions as codec
- Change: update codec binary

## Feb 21, 2022
- Change: update boot.sh

## Feb 14, 2022
- Change: rename pw2 to setpw and small changes
- Change: reuse code tab and use default ws if nothing is defined
- Change: add product.json
- Change: improve default workspaces
- Fix: keybindings
- Fix: set version 3.12.0 for code-server
- Fix: welcome message and missing files
- Add: custom user script descriptions and new codec cmd
- Change: some changes

