#!/bin/sh
qemu-system-i386 -bios bios.bin -m 4G -enable-kvm -cdrom mountpoint/workdir/software-fireengine-*.iso -boot d
