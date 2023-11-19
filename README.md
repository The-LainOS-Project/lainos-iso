# lainos-iso
Modified Archiso with Calamares installer for LainOS ISO build; uses linux kernel 6.6.1-zen1-1.

Prerequisites: Have the lainos_repo (https://github.com/The-LainOS-Project/lainos_repo) in a local repo and adjust /lainos-iso/pacman.conf accordingly to use this repo.

To build this ISO, clone this repository, cd into it, and execute the following command to create the ISO:

`sudo mkarchiso -v -w /home/USER/work -o /home/lain/out /home/USER/lainos-iso/`

The ISO will appear in `/home/out/` and the `/home/work/` folder can be deleted.

Afer booting up the ISO, select xfce session, then enter no password at the login screen to enter the xfce live installation environment.

Small issue, need to add systemd-resolved service for DNS, but the iso boots, installs the system using Calamares along with hyprland and openbox, and removes XFCE when finished. Execute `systmctl start systemd-resolved` to add DNS resolution for the time being. Or fix it for me.
