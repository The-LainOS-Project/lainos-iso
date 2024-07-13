# lainos-iso
Modified Archiso profile with Calamares installer for LainOS ISO build.

This ISO build installs all of the packages found in the LainOS Arch script(https://codeberg.org/LainOS/LainOS-ricer-arch) using Calamares and leaves an installation with Hyprland and Openbox(Xfce is deleted during the installation). This ISO build precedes the final LainOS ISO build as some refinements may need to be included for completion.

Prerequisites: Have the LainOS repo (`git clone https://github.com/The-LainOS-Project/lainos_repo`) in a local repo and adjust `/airootfs/etc/pacman.conf` accordingly to use this repo.

NEW NOTE 13/06/2024: In order to build this ISO you must have the`lainos-calamares-config` package in your local repo.(it is too big for the binary to fit in GitHub without paying for repo space so you'll have to build the package yourself.) It can be found here: https://github.com/The-LainOS-Project/lainos-calamares-config

To build the ISO, clone this repository, cd into it, and execute the following command:

`sudo mkarchiso -v -w /home/USER/work -o /home/USER/out /home/USER/lainos-iso/`

The ISO will appear in `/home/USER/out/` and the `/home/USER/work/` folder can be deleted.

After booting up the ISO, select Xfce session(Calamares only works in Xfce), then enter no password into the login prompt to enter the Xfce live installation environment.

Issues: an /etc/inputrc file needs to be included to fix keyboard mapping and fix meta key issues.