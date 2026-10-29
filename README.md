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

# Windows / Qbit Dual Boot Installation

**Install Qbit Linux 1.0 next to Windows: USB stick, BIOS / UEFI, shrinking your drive and the installer.**

Hi, I'm Diniy. I built Qbit Linux with live-build and the KDE Plasma desktop, and I wrote this guide so you can install it.

Follow the steps in order. Read every warning box, because those are the spots where people usually get stuck or lose files. Take your time. If you get lost, the [Troubleshooting](#if-something-goes-wrong) section near the end and my GitHub page are there to help.

| About 2.9 GB | 8 GB or more | 1 to 2 hours |
| --- | --- | --- |
| the download | an empty USB flash drive | with no rush |

---

## What you need before you start

- **A USB flash drive.** 8 GB or bigger. Everything on it will be erased, so use an empty one.
- **A PC.** Windows 10 or 11 if you want dual boot. Any 64-bit PC works if Qbit gets the whole disk. There is also a guide for Linux users on far down in this guide : [Building the ISO on a Debian or Arch based system](Build-Qbit-ISO-Debian-Arch.md).
- **Free disk space.** Plan on 40 GB or more for Qbit. More room is better if you will install lots of apps.
- **Power and time.** Laptops: keep the charger plugged in. Set aside 1 to 2 hours so you never rush a step.

> [!CAUTION]
> **Back up first, then begin.**
> - Copy photos, documents and anything you cannot replace to an external drive or the cloud.
> - If Windows uses BitLocker, save your recovery key now. Step 3 shows how.
> - Laptops: plug in the charger before you start.
> - Read every screen before you click Next, especially the disk partitions screen.
>
> Choosing **Erase disk** deletes everything on that disk, Windows included. If you want dual boot, never pick it.

## The plan in 7 steps

| Step | What you do |
| --- | --- |
| 1. Download | Get the Qbit ISO file (about 2.9 GB). |
| 2. Write USB | Use Rufus to make a bootable stick. |
| 3. Prep Windows | Turn off Fast Startup, check BitLocker. |
| 4. Shrink drive | Free up space for Qbit in Disk Management. |
| 5. BIOS / UEFI | Let the PC start from your USB. |
| 6. Live boot | Start Qbit from the USB and look around. |
| 7. Install | Run the installer, set the computer name. |

> [!TIP]
> Giving Qbit the whole disk and no Windows? Skip steps 3 and 4.

---

## Step 1: Download Qbit Linux

**[Download Qbit Linux 1.0 (ISO)](https://akirabox.to/EL73gkBNE39B/file)**

| | |
| --- | --- |
| File name | `qbit-linux-1.0-rc3-amd64.hybrid.iso` |
| Size | about 2.9 GB |


## Step 2: Write the USB with Rufus

1. Get Rufus from its official site, [rufus.ie](https://rufus.ie), and open it. No installation is needed.
2. Plug in your USB stick. Everything on it will be erased.
3. **Device:** pick your USB stick. Check the size so you do not pick another drive.
4. **Boot selection:** click **SELECT** and choose the Qbit ISO file.
5. **Partition scheme:** GPT for modern PCs (UEFI). Use MBR only for very old PCs that have no UEFI.
6. Click **START**.

**Rufus pop-up questions:**

1. **Pick ISO Image mode.** Rufus asks how to write a hybrid ISO. Choose ISO Image mode. It is the same way I wrote and tested my USB.
2. **Accept the erase warning.** Rufus warns that all data on the USB will be destroyed. Make sure the right stick is selected, then click OK.
3. **Wait for READY.** Writing takes several minutes. Do not unplug the stick. When the bar says READY, click CLOSE.

## Step 3: Get Windows ready

*Skip this step if Qbit will replace Windows.*

**Turn off Fast Startup**

1. Open Control Panel, then Hardware and Sound, then Power Options.
2. Click "Choose what the power buttons do".
3. Click "Change settings that are currently unavailable".
4. Untick "Turn on fast startup" and click Save changes.

**Check BitLocker**

1. Open Settings, Privacy & security, Device encryption (or search "Manage BitLocker").
2. If it says On, open [aka.ms/myrecoverykey](https://aka.ms/myrecoverykey) and save your recovery key. Turning it off is the better option.
3. Windows may ask for that key after you change boot settings.

## Step 4: Shrink the Windows volume

1. Right-click the Start button and choose **Disk Management**.
2. Right-click your **C:** drive (the big NTFS one) and choose **Shrink Volume**. Make sure you have enough free disk space.
3. Enter the amount to shrink, in MB. 40 GB is 40960. The table below has more sizes.
4. Click **Shrink**. Wait a moment.
5. Look for a black bar labelled **Unallocated**. That is the room Qbit will use.

> [!WARNING]
> **Don't format it.** Leave the new space unallocated. Do not click "New Simple Volume".

**Common sizes in MB**

| For Qbit | Type in MB |
| --- | --- |
| 20 GB (minimum) | 20480 |
| 40 GB | 40960 |
| 50 GB | 51200 |
| 100 GB | 102400 |

> [!TIP]
> **Leave room for both.** Check how much space C: has free first, and don't shrink it so far that Windows runs out.

**What your disk should look like**

```text
Before:               [ EFI ][ Windows (C:) ............................ ][ Recov. ]
After shrinking:      [ EFI ][ Windows (C:) ........ ][ Unallocated ... ][ Recov. ]
After installing:     [ EFI ][ Windows (C:) ........ ][ Qbit Linux ..... ][ Recov. ]
```

## Step 5: Open BIOS / UEFI settings

**Method A: from Windows (easiest)**

1. Open Settings, System, Recovery.
2. Next to Advanced startup, click **Restart now**.
3. Choose Troubleshoot, Advanced options, UEFI Firmware Settings.
4. Click Restart. The BIOS / UEFI screen opens.

**Method B: tap a key at power-on**

Restart and tap the setup key again and again as soon as the logo appears. The table shows the usual keys.

| Brand | Setup key | Boot menu key |
| --- | --- | --- |
| Dell | F2 | F12 |
| HP | Esc, then F10 | F9 |
| Lenovo | F2 (or F1) | F12 |
| ASUS | F2 or Del | F8 or Esc |
| Acer | F2 | F12 |
| MSI | Del | F11 |

> [!TIP]
> **Not on the list?** Keys differ by model. Watch for the hint at power-on, or search your model's manual.

**What to change in BIOS**

1. **Boot mode: UEFI.** Use the same mode Windows uses (nearly always UEFI, not Legacy / CSM). Mixing modes breaks dual boot.
2. **Secure Boot:** if the USB will not start, turn Secure Boot off for the install.
3. **Storage mode:** leave it as it is. Only if the installer later shows no disk, ask for help before touching it (see Troubleshooting).
4. **Boot order:** put the USB first, or use the one-time boot menu. Then Save and Exit (usually F10). It is F12 on my Dell PC.

> [!WARNING]
> **Write it down.** Note every setting you change so you can undo it later if you need to.

## Step 6: Boot the live USB

1. Pick the USB in the boot menu. It may say "UEFI:" and the stick's brand.
2. In the Qbit menu choose **Live system (amd64)** and press Enter.
3. Wait for the desktop. You are now running Qbit from the stick.

> [!TIP]
> **Safe to explore.** Live mode changes nothing on your PC. Test Wi-Fi, sound and the display first. When it all looks right, start the installer.

## Step 7: Start the installer

1. Double-click **Install Qbit Linux** on the desktop. You can also find it in the app menu.
2. Wait 10 to 20 seconds for the "Qbit Linux Installer" window.
3. Walk through the pages in the order shown below. Don't close the window.

The sidebar shows where you are: **Welcome, Location, Keyboard, Partitions, Users, Summary, Install, Finish.**

### Welcome, Location and Keyboard

- **Welcome:** choose your language and click Next.
- **Location:** click your region and time zone on the map. This sets your clock.
- **Keyboard:** pick your layout, then type in the test box to be sure. Click Next.

### Partitions: pick your install type

| Option | What it does | Use it for |
| --- | --- | --- |
| **Erase disk** | Wipes the whole selected disk and installs Qbit. | **NOT for dual boot.** Only an empty disk, or when Qbit is the only system you want. |
| **Install alongside** | Keeps Windows. The installer shrinks a partition and puts Qbit next to it. You drag a slider to set the sizes. | Easiest dual boot. |
| **Manual partitioning** | You choose every partition. Best if you already shrank Windows in Step 4, because it uses that free space. | Dual boot, careful. |

> [!CAUTION]
> **Check the disk.** If the page lists more than one disk, confirm the name and size before you continue.

### Dual boot, easy way: Install alongside

1. Choose **Install alongside**.
2. Click the large NTFS partition that holds Windows, then you will see a divider.
3. Drag the divider so Qbit gets at least 40 GB and Windows keeps enough room.
4. Check the preview bar under the list, then click Next.

> [!NOTE]
> **No "Install alongside" option?** That can happen when free space already exists. Use Manual partitioning below. It works with exactly that space.

### Dual boot, manual: use the free space

1. Choose **Manual partitioning** and click Next.
2. Select the row called **Free Space** (the room from Step 4) and click Create.
3. **Size:** use all of it, or at least 40 GB.
4. **File system and mount point:** `ext4`, mounted at `/` (just a slash).
5. **EFI partition (UEFI PCs):** select the existing small FAT32 "EFI System" partition, click Edit, set Mount point to `/boot/efi` and choose to keep its data.
6. Click Next. Swap is optional.

> [!CAUTION]
> **Never touch these:** the Windows partition (NTFS), the Recovery partition, and never format the EFI partition. Deleting or formatting them can stop Windows from starting.

### Users: type qbit-linux as the computer name

| Field | What to type |
| --- | --- |
| Your name | Your Name |
| Username | yourname |
| **Computer name** | **`qbit-linux`** |
| Password | choose one you will remember |
| Repeat password | the same password |

- **Computer name:** type exactly `qbit-linux`. Use lowercase letters, one hyphen, no spaces.
- Your terminal prompt will then read `yourname@qbit-linux`.
- Pick a password you will remember. Write it down somewhere safe.

> [!TIP]
> **Why it matters:** the computer name becomes your host name, so it shows in the terminal and on your network.

### Summary, then Install

1. **Read the summary slowly.** Check the disk, the partitions, and the computer name.
2. **Not right?** Click Back and fix it. Nothing is changed yet.
3. **Happy?** Click Install, then confirm.
4. **Wait.** It takes several minutes, sometimes 20 or more. A Qbit slideshow shows while it works.

> [!WARNING]
> **While it runs:** don't unplug the USB, don't close the laptop lid, and keep the charger connected.

### Finish and first boot

1. Tick "Restart now" and click Done.
2. When the screen goes dark, pull out the USB stick.
3. Choose Qbit in the menu. Dual boot also shows Windows.

**Windows missing from the menu?** In Qbit open a terminal and run:

```bash
sudo nano /etc/default/grub
```

In that file set `GRUB_DISABLE_OS_PROBER=false` (add the line if it is missing), save with Ctrl+O, Enter, Ctrl+X. Then run:

```bash
sudo update-grub
```

Restart. Or you can just use the one-time boot key and boot into Windows from UEFI / BIOS.

---

## If something goes wrong

| Problem | What to try |
| --- | --- |
| **USB not in the boot menu** | Write it again with Rufus using the other mode (DD Image mode). Try another USB port, and check that the boot mode is UEFI. |
| **Secure Boot blocks it** | Turn Secure Boot off in BIOS for the install, as in Step 5. |
| **Black screen or stuck logo** | At the Qbit menu press `e`, add the word `nomodeset` at the end of the line that starts with `linux`, then press Ctrl+X. |
| **Installer shows no disk** | Some PCs hide the drive behind Intel RST / VMD. Ask for help on GitHub before changing it, because that can stop Windows booting. |
| **Windows not in the menu** | Use the os-prober fix above, or pick Windows from your PC's boot menu. |
| **Windows asks for a key** | BitLocker wants the recovery key you saved in Step 3. Enter it, and Windows starts as normal. |

# Building the Qbit ISO on a Debian or Arch based system

Qbit Linux is built with Debian's [live-build](https://wiki.debian.org/DebianLive). This repository holds everything needed to rebuild the ISO yourself. This guide is by Diniy.

> [!NOTE]
> I build Qbit on a Debian-based host. The **Debian / Ubuntu section is the tested path.** The Arch section explains the safest way to build from an Arch-based system, but I have not built Qbit directly on Arch, so treat the AUR route as untested.

## What you need

- An x86_64 PC (or a VM) with an internet connection and `sudo`.
- About **20 GB of free disk space**. Keep more free if you also keep old builds around.
- Time: from about half an hour to a couple of hours, depending on your internet and CPU.

---

## Part A: Debian, Ubuntu and other Debian-based systems

Qbit is based on Debian 13 (Trixie). A **Debian 13 host is the easiest choice.** On an older Debian or on Ubuntu, if `debootstrap` says it does not know `trixie`, install a newer `debootstrap` or build on a Debian 13 machine or VM instead.

**1. Install the tools**

```bash
sudo apt update
sudo apt install git live-build debootstrap
```

**2. Get the source**

```bash
git clone https://github.com/girmadinaol10-spec/qbit.git
cd qbit
```

**3. Build**

```bash
./build.sh
```

When it finishes, the ISO and its checksum are in `out/`:

```text
out/qbit-linux-1.0-amd64.hybrid.iso
out/SHA256SUMS
```

**4. Verify the file**

```bash
cd out
sha256sum -c SHA256SUMS
```

You should see `OK` next to the ISO.

### Building by hand with live-build

`build.sh` is the easy way. If you want to run the stages yourself:

```bash
sudo lb config
sudo lb build
```

`lb config` runs the settings in `auto/config`, and `lb build` creates the image. The ISO appears in the project folder.

---

## Part B: Arch and Arch-based systems (Manjaro, EndeavourOS, CachyOS and others)

live-build is a Debian tool, so an Arch host has to borrow Debian's tools. You have two options.

### Option 1 (recommended): build inside a Debian 13 virtual machine

This is the most reliable route because the build then runs on the same kind of system Qbit is built on.

1. Create a VM (QEMU/KVM, VirtualBox or GNOME Boxes) with **4 GB RAM or more** and a **40 GB disk or more**.
2. Install Debian 13 in it.
3. Inside the VM, follow **Part A** above.
4. Copy `out/qbit-linux-1.0-amd64.hybrid.iso` back to your Arch machine, for example with `scp`.

### Option 2: install the Debian tools from the AUR (untested)

Some people install `live-build`, `debootstrap` and `debian-archive-keyring` from the AUR and build directly on Arch. I have not tried this for Qbit. Check the package names in your AUR helper before you rely on it:

```bash
yay -S live-build debootstrap debian-archive-keyring
```

Then continue with steps 2 to 4 of Part A (`git clone`, `./build.sh`, verify). If the build fails at the bootstrap stage, switch to Option 1.

---

## Where things live in the repository

| Path | Purpose |
| --- | --- |
| `build.sh` | Builds the ISO |
| `auto/` | live-build entry points (`config`, `build`, `clean`) |
| `config/package-lists/` | Packages installed in the image |
| `config/includes.chroot/` | Files copied into the system (themes, branding, defaults) |
| `config/includes.chroot_before_packages/` | Files copied in before packages are installed (apt pins) |
| `config/includes.binary/` | Files placed on the ISO itself (boot menu pictures) |
| `config/hooks/normal/` | Scripts that run while the image is built |

To change what is installed, edit the lists in `config/package-lists/`. A list ending in `.disabled` is switched off; rename it to `.list.chroot` to enable it.

## Testing your ISO in a virtual machine

```bash
sudo apt install qemu-system-x86 ovmf
```

BIOS boot:

```bash
qemu-system-x86_64 -enable-kvm -m 4096 -smp 4 -cdrom out/qbit-linux-1.0-amd64.hybrid.iso -boot d
```

UEFI boot (the OVMF path can differ on your system, so check `ls /usr/share/OVMF /usr/share/ovmf`):

```bash
qemu-system-x86_64 -enable-kvm -m 4096 -smp 4 -bios /usr/share/ovmf/OVMF.fd -cdrom out/qbit-linux-1.0-amd64.hybrid.iso -boot d
```

To test an install, add a blank disk first:

```bash
qemu-img create -f qcow2 qbit-test.qcow2 30G
```

and add `-drive file=qbit-test.qcow2,format=qcow2` to the command. To boot the installed system afterwards, run the same command without `-cdrom` and `-boot d`.

---

## Problems I ran into while building

These are real problems from building Qbit, so you can skip the guesswork.

**The build finishes instantly and the chroot has no kernel or packages.**
live-build skips any stage whose stamp file exists in `.build/`. A leftover `.build/` from an older build makes it think the work is done. Start fresh by removing the build folders (see "Starting completely fresh" below).

**You edited files in `config/` and the ISO did not change.**
Same cause. After you change `config/includes.chroot` or the chroot hooks, the chroot stages must run again, then the binary stages so the squashfs is rebuilt. The simplest way is a fresh build.

**"Permission denied" when you edit a file in `config/` or `auto/`.**
An earlier `sudo` run left root-owned files. Give them back to yourself:

```bash
sudo chown -R "$USER:$USER" config auto
```

**The installer window does not open.**
Calamares refuses to start if the `componentName` line in `config/includes.chroot/etc/calamares/branding/qbit/branding.desc` does not match the folder name. It must say `componentName:   qbit`.

**You run out of disk space.**
Old `chroot`, `binary` and `cache` folders and old ISOs add up fast. Check `df -h` before building.

### Starting completely fresh

First make sure nothing is still mounted inside the build folder. This command must print **nothing**:

```bash
findmnt -R chroot
```

Only then remove the old build state:

```bash
sudo rm -rf .build chroot binary cache
```

> [!WARNING]
> Move any ISO you want to keep out of the project folder first (for example to `~/qbit-iso-keep/`). Cleaning or rebuilding can delete or overwrite images that match the image name. Never run `rm -rf` on a `chroot` while something is still mounted in it, because `rm` follows the mounts.

---

## Welcome to Qbit

- **Download:** [https://akirabox.to/EL73gkBNE39B/file](https://akirabox.to/EL73gkBNE39B/file)
- **GitHub:** [github.com/girmadinaol10-spec/qbit](https://github.com/girmadinaol10-spec/qbit)
- **Checksum:** the SHA256 is in Step 1.

Questions or problems? [Open an issue](https://github.com/girmadinaol10-spec/qbit/issues) on my GitHub page and I will help.

*Made by Diniy.*

## Licences and credits

- Build scripts and configuration: MIT, see `LICENSE`.
- Qbit wallpapers: CC BY-SA 4.0 (declared in each wallpaper's `metadata.json`).
- The Qbit name, logo and boot splash: copyright 2026 girmadinaol10-spec, all rights reserved.
- Third-party themes, icons and fonts, and Debian packages: see `THIRD_PARTY.md`.
