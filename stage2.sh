#!/bin/sh
#stage2 :- debootstraps a vanilla rootfs for the appropriate architecture

#enter directory containing this script
cd $(dirname $(realpath $0))

if [ "$1" = "" ]; then
	echo "Argv1: <arch>"
	echo "eg. \"i386\""
	exit
else
	THEARCH="$1"
fi

#we mount the stuff for apt
mount none -t proc /proc
mount none -t sysfs /sys
mkdir -p /dev/pts
mount none -t devpts /dev/pts

#create /dev/null and /dev/zero
mknod -m 666 /dev/null c 1 3
mknod -m 666 /dev/zero c 1 5
chown root:root /dev/null /dev/zero

#fix permissions problems
chmod -Rv 700 /var/cache/apt/archives/partial/

chown -Rv devuan:devuan /var/cache/apt/archives/partial/

THEMIRROR="http://pkgmaster.devuan.org/merged"

apt-get update

mkdir "${PWD}/rootfs"

apt-get install -m -y debootstrap

apt-get install -m -y ntfs-3g mono-xbuild

#for efilinux
apt-get -m -y install gnu-efi

debootstrap --arch=${THEARCH} --variant=minbase --components=main,contrib,non-free --include=ifupdown testing "${PWD}/rootfs" "${THEMIRROR}"

printf "deb %s testing main contrib non-free-firmware\n" "${THEMIRROR}" > rootfs/etc/apt/sources.list
printf "deb-src %s testing main contrib non-free-firmware\n" "${THEMIRROR}" >> rootfs/etc/apt/sources.list

printf "software-fireengine\n" > "rootfs/etc/hostname"
chmod 644 "rootfs/etc/hostname"
chown root:root "rootfs/etc/hostname"

printf "127.0.0.1\tlocalhost\n" > "rootfs/etc/hosts"
printf "127.0.1.1\tlive-hybrid-iso\n" >> "rootfs/etc/hosts"
printf "::1\t\tlocalhost ip6-localhost ip6-loopback\n" >> "rootfs/etc/hosts"
printf "ff02::1\t\tip6-allnodes\n" >> "rootfs/etc/hosts"
printf "ff02::2\t\tip6-allrouters\n" >> "rootfs/etc/hosts"
chmod 644 "rootfs/etc/hosts"
chown root:root "rootfs/etc/hosts"

	#dependencies to build virus total uploader
	apt-get update && apt-get -y upgrade
	apt-get -m -y install git
	apt-get -m -y install build-essential qtchooser qt5-default libjansson-dev libcurl4-openssl-dev git zlib1g-dev
	apt-get -m -y install automake autoconf libtool libjansson-dev libcurl4-openssl-dev
	apt-get -m -y install make g++ qt5-qmake qtbase5-dev qtchooser zlib1g-dev libqt5gui5
	aapt-get -m -y install libcvtapi-dev

#unmount stuff
umount /proc
umount /sys
umount /dev/pts