
# Debian (12) tuning for Desktop usage
# 1/4
# Setting up repos and package mangers

### First update the repos and install nala and synaptic etc.:

```bash
    sudo apt update && sudo apt upgrade 
    sudo apt install vim git synaptic nala  
```

### Setting up flatpak and snapd

```bash
    sudo nala update
    sudo nala install flatpak
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo apt install snapd
    sudo snap install core
    snap refresh
```

### Installing multimedia codecs

```bash
    sudo nala install libavcodec-extra vlc
```

### Adding backports repo
add this: 

`deb http://deb.debian.org/debian bookworm-backports main`

in:

```bash
    sudo vim /etc/apt/sources.list.d/backports.list
    sudo apt update
```

# 2/4
# Performance tweaks

### Enable Preloading
Enables preloading apps just by installing it and no further configuration required.

```bash
    sudo nala install preload
```

### Disable swapiness
Number is a ratio for example 20 = 20% of ram size. Adjust as needed. 

0 is recommended for maximum performance (>16gb of ram)

Recommended Ratios: 32:0, 16:10, 8:20, 4:50, 2:70 

```bash
    sudo sysctl vm.swappiness=0

```

### Faster bootup

Use below command to see what slows down the bootup:

```bash
    sudo systemd-analyze
    sudo systemd-analyze blame | head
```

Then use this command to disable it (google what the service does first...some are totally uneeded...1 took 7secs for example and it was useless)

```bash
    sudo systemctl disable <service name>
```

In this file change the value of `GRUB_TIMEOUT` to `2` 

```bash
    sudo vim /etc/default/grub
```


### Faster shutdown

```bash
    sudo cp /etc/systemd/system.conf /etc/systemd/system.conf.old
    sudo vim /etc/systemd/system.conf
```

Uncomment and change `DefaultTimeoutStopSec=60s` to `DefaultTimeoutStopSec=5s` (or 3)

# 3/4
# Useful software recommendations and tweaks

### Remove libreoffice (To get the latest from flatpak)

Go to synaptic pacakge manager ( Installed it in first step) and find `libreoffice-core` select it for complete removal and apply the change.

### Some apps are better to be installed as .deb packages

For example `vscode` is one of them in my experience.

Prefer `apt install` to `dpkg` as dpkg can only install, remove, or query individual packages, apt offers additional functionality, such as automatically handling dependencies, retrieving and installing packages from remote locations, and upgrading all installed packages to their latest versions.

Steps:
- Download .deb from web
- sudo apt install <app_name>.deb

```bash
    sudo apt install ~/Downloads/<app_name>.deb
```

### Repos
```bash
    sudo nala install neovim qbittorrent r-base gcc g++ okular vlc 
```
### Flatpaks
#### Don't forget to install flatseal to manage flatpak app privileges 

```bash                       
flatpak install com.discordapp.Discord -y && flatpak install com.github.tchx84.Flatseal -y  && flatpak install com.obsproject.Studio -y && flatpak install com.spotify.Client -y && flatpak install com.stremio.Stremio -y && flatpak install com.valvesoftware.Steam -y && flatpak install io.missioncenter.MissionCenter -y                   && flatpak install org.libreoffice.LibreOffice -y && flatpak install org.mozilla.Thunderbird -y && flatpak install org.signal.Signal -y && flatpak install org.telegram.desktop -y && flatpak install org.texstudio.TeXstudio -y                          
```

### Snap

skype

ps: skype has disabled screen sharing in wayland , some other apps that use screen share might need X11 session.

### Updating system:
```bash
    sudo nala update && sudo nala upgrade && flatpak update && snap refresh
```

# 4/4
# Backup system
### Timeshift

Use timeshift to create a restore point.

```bash
    sudo nala install timeshift
    sudo timeshift-gtk
```
