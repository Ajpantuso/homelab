#! /usr/bin/env bash

set -euxo pipefail

BOOT_TMP=/tmp/RPi4boot

function install() {
    coreos-installer install \
        -a aarch64 -s "${STREAM}" \
        -i config.ign \
        --append-karg nomodeset "${DEVICE}"
}

function prepare_boot_files() {
    mkdir -p "${BOOT_TMP}/boot/efi/"

    dnf install -y \
        --downloadonly \
        --forcearch=aarch64 \
        --release="${RELEASE}" \
        --destdir=/tmp/RPi4boot/ \
        uboot-images-armv8 bcm283x-firmware bcm283x-overlays

    for rpm in "${BOOT_TMP}"/*rpm; do
        rpm2cpio "${rpm}" | cpio -idv -D "${BOOT_TMP}"
    done

    mv "${BOOT_TMP}/usr/share/uboot/rpi_arm64/u-boot.bin" \
        "${BOOT_TMP}/boot/efi/rpi-u-boot.bin"
}

function copy_boot_files() {
    part=$( \
        lsblk "${DEVICE}" -J -oLABEL,PATH  | \
        jq -r '.blockdevices[] | select(.label == "EFI-SYSTEM")'.path \
    )

    mnt=/tmp/FCOSEFIpart

    mkdir "${mnt}"
    mount "${part}" "${mnt}"
    rsync -avh --ignore-existing "${BOOT_TMP}/boot/efi/" "${mnt}"
    umount "${part}"
}

function main() {
    install
    prepare_boot_files
    copy_boot_files
}

main "$@"
