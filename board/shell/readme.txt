64-bit Ghost buildroot running on the shell (raspberry pi cm3 SOM)

Intro
=====


How to build it
===============

Configure Buildroot
-------------------

  $ make shell_defconfig

Build the rootfs
----------------

Note: you will need to have access to the network, since Buildroot will
download the packages' sources.

You may now build your rootfs with:

  $ make

(This may take a while, consider getting yourself a coffee ;-) )

Result of the build
-------------------

After building, you should obtain this tree:

    output/images/
    +-- bcm2710-rpi-cm3.dtb         [1]
    +-- boot.vfat
    +-- rootfs.ext4
    +-- userfs.f2fs
    +-- rpi-firmware/
    |   +-- bootcode.bin
    |   +-- cmdline.txt
    |   +-- config.txt
    |   +-- fixup.dat
    |   +-- start.elf
    +-- sdcard.img
    `-- zImage

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

