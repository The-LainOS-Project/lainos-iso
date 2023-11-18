# lainos-iso
Modified Archiso with Calamares installer for LainOS ISO build; uses linux kernel 6.6.1-zen1-1.

Prerequisites: Have the lainos_repo (https://github.com/The-LainOS-Project/lainos_repo) in a local repo and adjust /lainos-iso/pacman.conf accordingly to use this repo.

To build this ISO, clone this repository, cd into it, and execute the following command to create the ISO:

`sudo mkarchiso -v -w /home/USER/work -o /home/lain/out /home/USER/lainos-iso/`

The ISO will appear in /home/out/ and the /home/work/ folder can be deleted.

Afer booting up the ISO, select xfce session, then enter no password at the login screen to enter the xfce live installation environment.

Issues: Live Xfce session does not connect to internet even with wifi or ethernet cable connected. "airootfs.sfs does not exist" error when trying to install.
