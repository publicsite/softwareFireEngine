#!/bin/sh
#stage3 :- customises a vanilla rootfs

if [ "$1" = "" ]; then
	echo "Argv1: <arch>"
	echo "eg. \"i386\""
	exit
else
	THEARCH="$1"
fi

if [ "$(echo "$2" | cut -c 1-12)" != "linux-image-" ]; then
	echo "Argv2: the name of the kernel package for your architecture"
	echo "eg. \"linux-image-686\""
	exit
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

chown -Rv _apt:root /var/cache/apt/archives/partial/

export DEBIAN_FRONTEND=noninteractive
export LC_ALL=C
export LANG=C
export LANGUAGE=C

#this stuff doesn't like chroots, so we get rid of it for the purposes of building
apt-get -y autoremove  exim4-config exim4-base exim4-daemon-light exim4-config-2 exim4

#update the system
apt-get -y update && apt-get -y upgrade

apt-get -m -y install task-laptop \
task-english \
sysvinit-core \
sysv-rc \
live-config-sysvinit \
xdg-utils \
xorg \
xserver-xorg-input-all \
xserver-xorg-video-all \
va-driver-all openbox \
obconf \
xfce4-panel \
xfce4-terminal \
xfce4-whiskermenu-plugin \
thunar \
thunar-archive-plugin \
xdm \
mousepad \
file-roller \
gparted \
htop \
firmware-linux-free

apt-get -m -y install --no-install-recommends \
"$2" \
unzip \
pciutils \
wget \
bc \
breeze-icon-theme \
extlinux \
syslinux-common \
wget \
nano \
vim \
file \
iputils-ping \
fonts-crosextra-caladea \
fonts-crosextra-carlito \
fonts-liberation2 \
fonts-linuxlibertine \
fonts-noto-core \
fonts-noto-extra \
fonts-noto-ui-core \
fonts-sil-gentium-basic \
xfdesktop4 \
xfdesktop4-data \
locales \
whois \
telnet \
aptitude \
lsof \
time \
tnftp \
xserver-xorg-input-synaptics \
gnome-icon-theme \
sudo \
fdisk \
less \
xfce4-session \
connman \
connman-gtk \
xfce4-power-manager \
xfce4-power-manager-plugins \
dns323-firmware-tools \
firmware-linux-free \
grub-firmware-qemu \
hdmi2usb-fx2-firmware \
sigrok-firmware-fx2lafw \
amd64-microcode \
bluez-firmware \
dahdi-firmware-nonfree \
firmware-amd-graphics \
firmware-atheros \
firmware-bnx2 \
firmware-bnx2x \
firmware-brcm80211 \
firmware-cavium \
firmware-intel-sound \
firmware-iwlwifi \
firmware-libertas \
firmware-linux \
firmware-linux-nonfree \
firmware-misc-nonfree \
firmware-myricom \
firmware-netronome \
firmware-netxen \
firmware-qcom-media \
firmware-qlogic \
firmware-realtek \
firmware-samsung \
firmware-siano \
firmware-ti-connectivity \
firmware-zd1211 \
intel-microcode \
tzdata

apt-get -m -y install wine yara chkrootkit clamav clamdscan lynis testdisk safecopy ca-certificates epiphany-browser smartmontools gpart ffmpeg

apt-get -m -y mono-runtime

apt-get -m -y install libqt5widgets5 #dependencies to run VirusTotalUploader

apt-get -m -y install libevtx-utils #for reading windows logs

apt-get -m -y install jq curl # for circl virus checker script

#to check
apt-get -m -y install vbindiff openscap-scanner

###DROPPED IN V2
##apt-get -m -y install memtester dvdisaster winbind p7zip-full
##apt-get -m -y install conky iftop nmon monitorix #system monitors
##apt-get -m -y install rkhunter unhide.rb snort

#install yara-scanner and flare-capa
apt-get -m -y install python3-pip
pip install --break-system-packages yara-scanner
apt-get -m -y install cmake
pip install --break-system-packages flare-capa

#install https://github.com/malicialab/avclass https://github.com/jesparza/peepdf https://github.com/mandiant/flare-floss https://pypi.org/project/chipsec/
#note chipsec is also required for fwaudit
#flare-floss conflicts with peepdf so we don't install peed
pip install --break-system-packages avclass-malicialab flare-floss chipsec

###for fwaudit
##apt-get install -y build-essential gcc nasm linux-headers-$(uname -r) fwts

###for aktaion2
##apt-get install -y python3-numpy

echo "TYPE PASSWORD FOR: root"
passwd root

echo "TYPE PASSWORD FOR: user"
adduser user

gpasswd -a user sudo
/usr/sbin/groupadd power
gpasswd -a user power
gpasswd -a user users
gpasswd -a user bluetooth
gpasswd -a user plugdev
gpasswd -a user video
/usr/sbin/groupadd lpadmin
gpasswd -a user lpadmin

if [ "$(grep "%users ALL = NOPASSWD:/usr/lib/${THEARCH}-linux-gnu/xfce4/session/xfsm-shutdown-helper" /etc/sudoers)" = "" ]; then
	echo "" >> /etc/sudoers
	echo "# Allow members of group sudo to execute any command" >> /etc/sudoers
	echo "%sudo   ALL=(ALL:ALL) ALL" >> /etc/sudoers
	echo "" >> /etc/sudoers
	echo "# Allow anyone to shut the machine down" >> /etc/sudoers
	echo "%users ALL = NOPASSWD:/usr/lib/${THEARCH}-linux-gnu/xfce4/session/xfsm-shutdown-helper" >> /etc/sudoers
fi

if [ -f "rootfs/usr/share/X11/xorg.conf.d/40-libinput.conf" ]; then
	#delete this because we will write to it
	if [ -f "rootfs/etc/X11/xorg.conf.d/40-libinput.conf" ]; then
	rm "rootfs/etc/X11/xorg.conf.d/40-libinput.conf"
	fi
	OLD_IFS="$IFS"
	IFS="$(printf "\n")"
	cat "rootfs/usr/share/X11/xorg.conf.d/40-libinput.conf" | while read line; do
		if [ "$line" = "        Identifier \"libinput touchpad catchall\"" ]; then
			echo "$line" >> "rootfs/etc/X11/xorg.conf.d/40-libinput.conf"
			echo "        Option \"Tapping\" \"on\"" >> "rootfs/etc/X11/xorg.conf.d/40-libinput.conf"
		else
			echo "$line" >> "rootfs/etc/X11/xorg.conf.d/40-libinput.conf"
		fi
	done
	IFS="$OLD_IFS"
fi

apt-get clean

cd /workdir

/workdir/getEquiptmentHost.sh /workdir
/workdir/installEquiptmentHost.sh /workdir

freshclam

rm /etc/resolv.conf
rm -rf /tmp/*

rm /root/.bash_history

#unmount stuff
umount /proc
umount /sys
umount /dev/pts
