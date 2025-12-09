<div style="text-align:center;">
  <img src="logo.png" alt="Dual Power logo" />
</div>

Dual Power is an out-of-the-box setup for Arch/EndevourOS Linux. It is meant to be
deployed over a fresh install of the Linux distro. It's
original inspiration was liberated from the [O****** project](https://github.com/basecamp/Omarchy).
Like O******, Dual Power is developer focused. It uses a different
collection of software to make up it's base.

## Install playbook

Current this is a manual install process, outlined below.

### Base System + Niri + Noctalia

Start with installing vanilla Arch Linux or EndevourOS (with no desktop).

```bash
# Base system install up through desktop
sudo pacman -Syu base-devel git gum niri xwayland-satellite xdg-desktop-portal-gnome xdg-desktop-portal-gtk alacritty

sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd .. && rm -Rf paru

paru -S matugen-git wl-clipboard cliphist cava qt6-multimedia-ffmpeg
paru -S wlsunset python3 evolution-data-server

paru -S quickshell gpu-screen-recorder brightnessctl ddcutil noctalia-shell

paru -S polkit-kde-agent

mkdir -p ~/.config/quickshell/noctalia-shell
curl -sL https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz | tar -xz --strip-components=1 -C ~/.config/quickshell/noctalia-shell

systemctl --user add-wants niri.service noctalia.service

# Kanshi NOTE: you will need to add a ~/.config/kanshi/config file with your profile(s) in order
# for kanshi to function
mkdir -p ~/.config/systemd/user && cp ./config/systemd/user/kanshi.service ~/.config/systemd/user/kanshi.service
systemctl --user enable kanshi.service
```

### User Software

Next we will add user software components.

#### Nvim

- TODO: The `PKGBUILD` at [omarchy-nvim](https://github.com/omacom-io/omarchy-pkgs/blob/master/pkgbuilds/omarchy-nvim/)

#### Term + OhMyBash

#### Librewolf + session selector

- `librewolf --ProfileManager`

#### Btop

- has custom config

## Components

### Plymouth, Limine as per O****** ?

- make logo ala <https://www.youtube.com/watch?v=_MmuViRTa0M>

### Desktop Shell + WM

- Niri + Noctalia
  - <https://yalter.github.io/niri/Getting-Started.html>
  - <https://github.com/noctalia-dev/noctalia-shell>
- Bar, Launcher
  - noctalia
- Bar widgets
  - wireless
    - widget:
    - app: impala
  - volume
    - widget:
    - app: wiremix
  - bluetooth
    - widget:
    - app: bluetui
  - power menu
    - noctalia
  - tray
    - noctalia
  - clock/calendar
    - noctalia
- Display Activation
  - [Kanshi](https://gitlab.freedesktop.org/emersion/kanshi)
