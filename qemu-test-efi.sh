#!/bin/sh
qemu-system-x86_64 -bios bios.bin -m 4G -enable-kvm -cdrom mountpoint/workdir/software-fireengine-*.iso -boot d
