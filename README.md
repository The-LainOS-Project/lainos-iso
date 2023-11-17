# lainos-iso
Modified Archiso with Calamares installer for LainOS ISO build; uses linux kernel 6.6.1-zen1-1.

Prerequisites: have the lainos-calamares-config package in a local repo and adjust pacman.conf accordingly by replacing my local repo with yours.

To use, clone this repository, cd into it, and execute the following command to create the ISO:

`sudo mkarchiso -v -w /home/USER/work -o /home/lain/out /home/USER/lainos-iso/`

The ISO will appear in /home/out/ and the /home/work/ folder can be deleted.

Afer booting up the ISO, select xfce session, then press enter at the login screen to enter the xfce live installation environment. 
