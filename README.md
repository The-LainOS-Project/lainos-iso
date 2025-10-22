<!--Reddit-->
<a href="https://www.reddit.com/r/LainOSdevelopers/" target="_blank">
  <img align="top" src="https://img.shields.io/badge/Reddit-FF4500?style=for-the-badge&logo=reddit&logoColor=white" alt="Reddit">
</a>
<!--Matrix-->
<a href="https://matrix.to/?fbclid=IwAR3aREfZ0l84eRuLdQ1RWq38Bm2mqvK4irokYoEWnvOibQPT7vqiIq_nhY8#/!hhlpPAPloYluaKwYAb:matrix.org?via=matrix.org" target="_blank">
  <img align="top" src="https://img.shields.io/badge/Matrix%20-%20%230047a7?style=for-the-badge&logo=matrix" alt="Matrix">
</a>
<!--Discord-->
<a href="https://discord.gg/atZ32vU24U" target="_blank">
  <img align="top" src="https://img.shields.io/badge/Discord%20-%20%234900ff?style=for-the-badge&logo=discord" alt="Discord">
</a>
<!--Web page-->
<a href="https://lainos.dev/" target="_blank">
  <img align="top" src="https://img.shields.io/badge/Lain%20OS%20web-3d3b93?style=for-the-badge&logo=Devbox" alt="Web">
</a>

# LainOS ISO Framework based on ArchISO (Calamares included)

Resources: Calamares installer for LainOS ISO build.

This ISO framework installs all of the packages found in the LainOS Arch Ricer script(<https://codeberg.org/LainOS/LainOS-ricer-arch>) using Calamares and leaves an installation with Hyprland and Openbox. This ISO build precedes the final LainOS ISO build as some refinements may need to be included for completion.

Prerequisites: You need to build the `lainos-calamares-config`(instructions below) and include it in the included `local_repo`(copy this repo to your home folder) and adjust `lainos-iso/lainos-iso/airootfs/etc/pacman.conf` accordingly to use this repo. (use the command `repo-add /home/user/local_repo.db.tar.gz *pkg.tar.zst` to link the repo etc.)

NEW NOTE 13/07/2024: In order to build this ISO you must have the lainos-calamares-config package in your local repo.(it is too big for the binary to fit in GitHub without paying for repo space so you'll have to store it in a local repo or just one it can be pulled from.) It can be found here: <https://gitlab.com/lainos/lainos-calamares-config>

To build the ISO, clone this repository, cd into it,and execute the following command:

`sudo mkarchiso -v -w /home/USER/work -o /home/USER/out /home/USER/lainos-iso/lainos-iso`

The ISO will appear in /home/USER/out/ and the /home/USER/work/ folder can be deleted.

Use a tool like Balena Etcher to write the iso to a USB drive.

After booting up the ISO, select Openbox session(Calamares installer only works in Openbox), then enter liveuser for the user, and no password into the login prompt to enter the Openbox live installation environment.

Connect to the internet. If you are not connected to internet, the installer will show an error message. Connect and restart the LainOS Installer, just make sure you are connected before installing.

The system is nice to use now and daily drivable.

Post installation:

Issue the command `sudo pacman -Syyu` to update the repo databases along with LainOS. 
Issue the command `nano` to start LazyVim, let it update, then press Shift + U to force more updates, Exit LazyVim as you would vim.
