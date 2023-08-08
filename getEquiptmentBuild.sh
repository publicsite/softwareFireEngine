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

###	get the programs	###

#linux programs
"${myBuildsDir}/efilinux/efilinux.myBuild" get
"${myBuildsDir}/qt-virustotal-uploader/qt-virustotal-uploader.myBuild" get
"${myBuildsDir}/yara-rules/yara-rules.myBuild" get /workdir/rootfs
"${myBuildsDir}/capa-rules/capa-rules.myBuild" get /workdir/rootfs

##TO POSSIBLY DO AT A LATER DATE
#"${myBuildHome}"/myBuildsBuild/forticlient/TODO     forticlient.myBuild get

###WORKING BUT DROPPED IN V2
##"${myBuildHome}"/myBuildsBuild/recuperabit/recuperabit.myBuild get /workdir/rootfs

###This installation is broken
##"${myBuildHome}"/myBuildsBuild/apt-hunter/apt-hunter.myBuild get /workdir/rootfs
##"${myBuildHome}"/myBuildsBuild/ultradefrag-linux/ultradefrag-linux.myBuild get
##"${myBuildHome}"/myBuildsBuild/ultradefrag-linux/ultradefrag-linux.myBuild extract
