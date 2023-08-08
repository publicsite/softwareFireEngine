== What it is ... ==

Software fire engine is for fighting virtual 'fires'. It contains software to ...

- Remove viruses and spyware
- Software for defragmentation and disk checking
- Auditing and detecting rootkits
- Backing up, system monitors and more ...

It is a live ISO distro based on Devuan. It contains a mixture of software for Win32 and software for Linux, utilising Wine.

It can fit on Blu-Ray and USB. The ISO is too big for DVD or CD.

== To generate the ISO, from a Linux distro... ==

cd to the directory containing the sources and run
 ./stage1.sh i386 linux-image-686

this will take a long time and requires an internet connection

you will be prompted for a password for root

you will then be prompted for a password for the user account

it will ask you for information about the user, just keep pressing ENTER and then type Y and hit ENTER again

there are several installation setups to complete, install to the default location in all cases

the final iso will be located in

$PWD/mountpoint/workdir/software-fireengine-i386.iso

==Using==

Login as root.

There are some docs in a folder on the desktop for using some of the tools.