#!/bin/sh
#myBuild options

#environment variables
export myBuildHome="$1"
export myBuildHelpersDir="${myBuildHome}/helpers"
export myBuildSourceDest="${myBuildHome}/sourcedest"
export myBuildExtractDest="${myBuildHome}/extractdest"
export myBuildsDir="${myBuildHome}/myBuildsBuild"

mkdir "$myBuildSourceDest"
mkdir "$myBuildExtractDest"

export J="-j12"

#this would be for binutils search paths, but i am playing my luck to see if i can go without it
#ld --verbose | grep SEARCH_DIR | tr -s ' ;' \\012
export BITS='32'

#architecture='x86' #the architecture of the target (used for building a kernel)
#export architecture

export TARGET="i686-linux-gnu" #the toolchain we're creating
export ARCH='x86' #the architecture of the toolchain we're compiling from
export BUILD="i686-linux-gnu" #the toolchain we're compiling from, can be found by reading the "Target: *" field from "gcc -v", or "gcc -v 2>&1 | grep Target: | sed 's/.*: //" for systems with grep and sed

export SYSROOT="${myBuildHome}/installDir" #the root dir

mkdir "$SYSROOT"

export PREFIX='/usr' #the location to install to

###	install the programs	###

export DISPLAY=:0.0
export LIBGL_ALWAYS_SOFTWARE=1

#linux software
"${myBuildsDir}/efilinux/efilinux.myBuild" extract
"${myBuildsDir}/efilinux/efilinux.myBuild" build
"${myBuildsDir}/qt-virustotal-uploader/qt-virustotal-uploader.myBuild" build
"${myBuildsDir}/qt-virustotal-uploader/qt-virustotal-uploader.myBuild" install /workdir/rootfs
"${myBuildsDir}/yara-rules/yara-rules.myBuild" install /workdir/rootfs
"${myBuildsDir}/capa-rules/capa-rules.myBuild" install /workdir/rootfs

###WORKING BUT DROPPED IN V2
##"${myBuildHome}"/myBuildsBuild/recuperabit/recuperabit.myBuild install /workdir/rootfs

###This installation is broken
##"${myBuildHome}"/myBuildsBuild/apt-hunter/apt-hunter.myBuild install /workdir/rootfs
##"${myBuildHome}"/myBuildsBuild/ultradefrag-linux/ultradefrag-linux.myBuild build