# Qbit Linux

Quantum-bit Linux is a Debian 13 (Trixie) based live and installable distribution built by Dinaol Girma aka Diniy with the KDE Plasma 6 desktop and additional hyperland sddm . The ISO is built with Debian's [live-build](https://wiki.debian.org/DebianLive); this repository contains everything needed to rebuild it.

## What is included

- KDE Plasma 6 on Wayland, with the Vivid Dark look, Qbit wallpapers, boot splash and login screen
- hyperland sddm/Cybersecurity related aka qbit cyber
- Calamares graphical installer, with dual-boot support (os-prober, ntfs-3g)
- zsh as the default shell, with syntax highlighting, suggestions and command correction
- Konsole preconfigured with a transparent profile
- Wobbly Windows and Magic Lamp effects enabled by default
- PipeWire audio, Bluetooth, NetworkManager
- ufw and KDE's firewall settings page (a build hook sets ufw to start on boot), AppArmor, automatic security updates, optional disk encryption in the installer

### Login sessions

| Session | Status |
|---|---|
| Qbit (Plasma) | The standard Qbit desktop |
| Hyper-bit (local ai host) |not preconfigured, i prepared it for my personal project |
| Qbit Cyber |hyperland|

## Building the ISO

You need a Debian or Debian-based machine, an internet connection, `sudo`, and about 20 GB of free disk space.

```bash
git clone https://github.com/girmadinaol10-spec/qbit.git
cd qbit
./build.sh
```

The ISO and its checksum end up in `out/`:

```
out/qbit-linux-1.0-amd64.hybrid.iso
out/SHA256SUMS
```

Verify a download with `sha256sum -c SHA256SUMS`.

## Trying it in a virtual machine

```bash
sudo apt install qemu-system-x86 ovmf
# BIOS boot
qemu-system-x86_64 -enable-kvm -m 4096 -smp 4 -cdrom out/qbit-linux-1.0-amd64.hybrid.iso -boot d
# UEFI boot
qemu-system-x86_64 -enable-kvm -m 4096 -smp 4 -bios /usr/share/ovmf/OVMF.fd -cdrom out/qbit-linux-1.0-amd64.hybrid.iso -boot d
```

## Installing next to Windows

Back up your data first, and boot the installer in UEFI mode (the same mode Windows uses). In the installer choose **Manual partitioning**, create the root partition (ext4, mount point `/`) in the free space, and set the existing EFI System Partition's mount point to `/boot/efi` **without formatting it**. Qbit installs its bootloader to its own `qbit` folder on that partition. If Windows uses BitLocker, keep your recovery key at hand.

## Repository layout

| Path | Purpose |
|---|---|
| `build.sh` | Builds the ISO |
| `auto/` | live-build entry points (`config`, `build`, `clean`) |
| `config/package-lists/` | Packages installed in the image |
| `config/includes.chroot/` | Files copied into the system (themes, branding, defaults) |
| `config/includes.chroot_before_packages/` | Files copied in before packages are installed (apt pins) |
| `config/includes.binary/` | Files placed on the ISO itself (boot menu pictures) |
| `config/hooks/normal/` | Scripts that run while the image is built |

To change what is installed, edit the lists in `config/package-lists/`. A list ending in `.disabled` is switched off; rename it to `.list.chroot` to enable it.

## Status and known limitations

- Early release, tested in QEMU.
- The live ISO may not boot with Secure Boot enabled. Turn it off to run the installer.
- The Plasma X11 session is hidden at the login screen.
- Hyprland is not in Debian 13's repositories, so it is not included. but im planing to include it in this github repo
- The boot menu pictures replace live-build's defaults after the menus are generated; a future live-build release may change how those menus are created.

## Licences and credits

- Build scripts and configuration: MIT, see `LICENSE`.
- Qbit wallpapers: CC BY-SA 4.0 (declared in each wallpaper's `metadata.json`).
- The Qbit name, logo and boot splash: copyright 2026 girmadinaol10-spec, all rights reserved.
- Third-party themes, icons and fonts, and Debian packages: see `THIRD_PARTY.md`.
