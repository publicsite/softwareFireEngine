#!/bin/sh
qemu-system-x86_64 -m 4G -enable-kvm -cdrom mountpoint/workdir/software-fireengine-*.iso
