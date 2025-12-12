<div style="text-align:center;">
  <img src="logo.png" alt="Dual Power logo" />
</div>

Dual Power is an out-of-the-box setup for Arch/EndevourOS Linux. It is meant to be
deployed over a fresh install of the Linux distro. It's
original inspiration was liberated from the [O****** project][2].
Like O******, Dual Power is developer focused. It uses a different
collection of software to make up it's base, although it borrows
a few components (like its LazyVim setup).

It should be noted that this repository/project is NOT meant to
compete with O****** (at least not on its own terms). It's merely
yet another meta-distro, "pre-riced for a certain setup", but without
a focus on built-in configurability for the defaults. So, if your immediately
reaction to any of the software, aesthetic, configuration, or other choices
made is negative, then we do apologize. Dual Power may not be the one for you.
The author is not interested in configurable defaults for desktop, term,
shell/bar/finder, DE, etc. You can install/configure/integrate those
yourself. Otherwise, please have Fun!

## Install playbook

Currently this is a manual install process, outlined below.

Start with installing vanilla Arch Linux or EndevourOS (with no desktop).

#### EndevourOS

Follow [this guide][1] for limine/snapper setup on a fresh EndevousOS install. Be sure
to select `btfs` and drive encryption. Choose "No Desktop" install option.

At one point in the guide you will delete the `/.snapshots` directory. When completing the guide, you will install `snap-pac`; This step will fail without that folder.

Run `sudo mkdir /.snapshots` and then `pacman -S snap-pac` again and it should complete without error.

#### Dual Power Install

```bash
# Base system install up through desktop
sudo pacman -Syu --needed base-devel git gum niri xdg-desktop-portal-gnome xdg-desktop-portal-gtk alacritty networkmanager ghostty sddm plymouth swayidle swaylock docker docker-compose docker-buildx paru

# edit /etc/group and add your user to the docker group
# then do
sudo usermod -a -G docker $USER

paru -Sy matugen-git wl-clipboard cliphist cava qt6-multimedia-ffmpeg xwayland-satellite-git librewolf-bin
paru -Sy wlsunset python3 evolution-data-server pacsea-bin dropbox neofetch

paru -Sy quickshell gpu-screen-recorder brightnessctl ddcutil noctalia-shell polkit-kde-agent

mkdir -p ~/.config/quickshell/noctalia-shell
curl -sL https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz | tar -xz --strip-components=1 -C ~/.config/quickshell/noctalia-shell
cp -Rf config/noctalia ~/.config

sudo mkdir -p /etc/sddm.conf.d && sudo cp ./etc/sddm.conf.d/autologin.conf /etc/sddm.conf.d/autologin.conf

# Noctalia enable
mkdir -p ~/.config/systemd/user && cp ./config/systemd/user/noctalia.service ~/.config/systemd/user/noctalia.service

chmod +x ./bin/*sh
sudo ./bin/default-keyring.sh
sudo ./bin/sddm.sh

# plymouth boot splash
sudo cp -Rf ./usr/share/plymouth/themes/dual-power /usr/share/plymouth/themes/dual-power
sudo plymouth-set-default-theme dual-power
# add plymouth to dracut setup
sudo tee /etc/dracut.conf.d/myflags.conf <<EOF >/dev/null
add_dracutmodules+=" plymouth "
EOF

# edit /etc/kernel/cmdline and append "quiet splash" to the end

# edit /etc/makepkg.conf
# change MAKEFLAGS line to read:
# MAKEFLAGS="-j$(nproc)"

#  Install kernel
sudo pacman -Syu linux-lqx

# setup nvim
git clone --depth=1 https://github.com/omacom-io/omarchy-pkgs
cd omarchy-pkgs/pkgbuilds/omarchy-nvim
makepkg -si
omarchy-nvim-setup
cd ../../../
rm -Rf omarchy-pkgs

# instlall onmybash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# Install local config
cp -Rf ./config/* ~/.config/

# Install application desktop files
mkdir -p ~/.local/share
cp -Rf ./local/share/applications ~/.local/share

# let us enable some systemd services, both global and user
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable docker.service --now
systemctl --user enable noctalia.service

sudo reboot
```

### The Software Suite

- Wayland, [Niri][5], and [noctalia-shell][4] make up the core user experience
  - Niri keybinds are slightly customized from Niri defaults and integrate with
  noctalia-shell actions
- [Kanshi][3] is installed and running via Niri
  - It is inert by default; you will need to provide your own `~/.config/kanshi/config`
  based on your monitor setup(s)
- [NeoVim] & [LaziVim] with some additional tweaks for the author's preferred workflow
  - rainbow brackets
  - autosave upon exiting insert mode, window/buffer change, etc

### Links

- Niri + Noctalia
  - <https://yalter.github.io/niri/Getting-Started.html>
  - <https://github.com/noctalia-dev/noctalia-shell>

[1]: https://forum.endeavouros.com/t/guide-how-to-install-and-configure-endeavouros-for-bootable-btrfs-snapshots-using-limine-and-limine-snapper-sync/69742
[2]: https://github.com/basecamp/Omarchy
[3]: https://wiki.archlinux.org/title/Kanshi
[4]: https://docs.noctalia.dev/docs/
[5]: https://yalter.github.io/niri/
