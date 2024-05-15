# Fedora CoreOS install on RPi

> should probably run all of this in a container or VM

```bash
RELEASE=40
mkdir -p /tmp/RPi4boot/boot/efi/
sudo dnf install -y --downloadonly --release=$RELEASE --forcearch=aarch64 --destdir=/tmp/RPi4boot/ uboot-images-armv8 bcm283x-firmware bcm283x-overlays
for rpm in /tmp/RPi4boot/*rpm; do rpm2cpio $rpm | sudo cpio -idv -D /tmp/RPi4boot/; done
sudo mv /tmp/RPi4boot/usr/share/uboot/rpi_arm64/u-boot.bin /tmp/RPi4boot/boot/efi/rpi-u-boot.bin
FCOSDISK=/dev/sdX #Update with attached sd card device id
STREAM=stable
sudo coreos-installer install -a aarch64 -s $STREAM -i config.ign --append-karg nomodeset $FCOSDISK
FCOSEFIPARTITION=$(lsblk $FCOSDISK -J -oLABEL,PATH  | jq -r '.blockdevices[] | select(.label == "EFI-SYSTEM")'.path)
mkdir /tmp/FCOSEFIpart
sudo mount $FCOSEFIPARTITION /tmp/FCOSEFIpart
sudo rsync -avh --ignore-existing /tmp/RPi4boot/boot/efi/ /tmp/FCOSEFIpart/
sudo umount $FCOSEFIPARTITION
```
