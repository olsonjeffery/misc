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

#### EndevourOS

Follow [this guide](https://forum.endeavouros.com/t/guide-how-to-install-and-configure-endeavouros-for-bootable-btrfs-snapshots-using-limine-and-limine-snapper-sync/69742) for limine setup on a fresh EndevousOS install.
Be sure to select `btfs` and drive encryption. Choose "No Desktop" install option.

```bash
sudo pacman -Syu limine snapper
```

#### Dual Power Install

```bash
# Base system install up through desktop
sudo pacman -Syu --needed base-devel git gum niri xdg-desktop-portal-gnome xdg-desktop-portal-gtk alacritty networkmanager ghostty sddm

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd .. && rm -Rf paru

paru -S matugen-git wl-clipboard cliphist cava qt6-multimedia-ffmpegx wayland-satellite-git librewolf-bin librewolf-bin
paru -S wlsunset python3 evolution-data-server pacsea-bin

paru -S quickshell gpu-screen-recorder brightnessctl ddcutil noctalia-shell

paru -S polkit-kde-agent

mkdir -p ~/.config/quickshell/noctalia-shell
#curl -sL https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz | tar -xz --strip-components=1 -C ~/.config/quickshell/noctalia-shell
cp config/noctalia ~/.config

sudo mkdir -p /etc/sddm.conf.d && sudo cp ./etc/sddm.conf.d/autologin.conf /etc/sddm.conf.d/autologin.conf

# Noctalia enable
mkdir -p ~/.config/systemd/user && cp ./config/systemd/user/noctalia.service ~/.config/systemd/user/noctalia.service
systemctl --user enable noctalia.service

# Boot/login flow: install plymouth/update
sudo cp -Rf ./usr/share/plymouth/themes/dual-power /usr/share/plymouth/themes/dual-power
sudo plymouth-set-default-theme dual-power

chmod +x ./bin/limine-snapper.sh ./bin/default-keyring.sh ./bin/sddm.sh
sudo ./bin/limine-snapper.sh
sudo ./bin/default-keyring.sh
sudo ./bin/sddm.sh

# enable networkmanager before the first boot into niri
sudo systemctl enable --now NetworkManager.service

#  Install kernel
sudo pacman -Syu linux-zen

chmod +x ./bin/limine-snapper.sh
sudo ./bin/limine-snapper.sh

sudo efibootmgr --create --disk "$(findmnt -n -o SOURCE /boot | sed 's/p\?[0-9]*$//')" --part "$(findmnt -n -o SOURCE /boot | grep -o 'p\?[0-9]*$' | sed 's/^p//')" --label "DualPower" --loader "\\EFI\\Linux\\dualpower_linux-zen.efi"

# Install application desktop files
mkdir -p ~/.local/share
cp -Rf ./local/share/applications ~/.local/share

sudo reboot
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
