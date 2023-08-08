#!/bin/sh
#myBuild options

#environment variables
export myBuildHome="$1"
export myBuildHelpersDir="${myBuildHome}/helpers"
export myBuildSourceDest="${myBuildHome}/sourcedest"
export myBuildExtractDest="${myBuildHome}/extractdest"

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

##These installed OK in wine and kind-of work
"${myBuildHome}"/myBuildsHost/w32-superantispyware/w32-superantispyware.myBuild install
"${myBuildHome}"/myBuildsHost/w32-spybot-search-destroy-portable/w32-spybot-search-destroy-portable.myBuild install /root/.wine/drive_c/
"${myBuildHome}"/myBuildsHost/w32-full-event-log-view/w32-full-event-log-view.myBuild install
"${myBuildHome}"/myBuildsHost/w32-nirsoft-uninstallview/w32-nirsoft-uninstallview.myBuild install /root/.wine/drive_c/
"${myBuildHome}"/myBuildsHost/w32-nirsoft-whatinstartup/w32-nirsoft-whatinstartup.myBuild install /root/.wine/drive_c/
"${myBuildHome}"/myBuildsHost/w32-nirsoft-devmanview/w32-nirsoft-devmanview.myBuild install /root/.wine/drive_c/

###THESE WORK BUT WERE DROPPED IN V2
##"${myBuildHome}"/myBuildsHost/w32-spyware-blaster/w32-spyware-blaster.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-ccleaner/w32-ccleaner.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-wine-gecko/w32-wine-gecko.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-wine-mono/w32-wine-mono.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-vb6-runtime-installer/w32-vb6-runtime-installer.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-hijack-this-portable/w32-hijack-this-portable.myBuild install /root/.wine/drive_c/
##"${myBuildHome}"/myBuildsHost/w32-contig/w32-contig.myBuild install /root/.wine/drive_c/
##"${myBuildHome}"/myBuildsHost/w32-defraggler/w32-defraggler.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-ultradefrag/w32-ultradefrag.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-recuva/w32-recuva.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-recovery-toolbox-for-cd/w32-recovery-toolbox-for-cd.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-recovery-toolbox-file-undelete/w32-recovery-toolbox-file-undelete.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-isobuster/w32-isobuster.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-glary-utilities/w32-glary-utilities.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-easy-pc-optimizer/w32-easy-pc-optimizer.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-wine-mono/w32-wine-mono.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-revo-uninstaller/w32-revo-uninstaller.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-system-explorer/w32-system-explorer.myBuild install

###this works, but is trialware, the licence wouldn't permit probably
##"${myBuildHome}"/myBuildsHost/w32-aida64-engineer-beta/w32-aida64-engineer-beta.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-aida64-extreme-beta/w32-aida64-extreme-beta.myBuild install

##These are dead links
##"${myBuildHome}"/myBuildsHost/w32-vba32-check/w32-vba32-check.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-vba32-antirootkit/w32-vba32-antirootkit.myBuild install

##These don't actually work (runtime) in wine
##"${myBuildHome}"/myBuildsHost/w32-avira/w32-avira.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-zonealarm/w32-zonealarm.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-nano-antivirus/w32-nano-antivirus.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-immunet/w32-immunet.myBuild install #this almost works but doesn't open panel
##"${myBuildHome}"/myBuildsHost/w32-emsisoft-emergency-kit/w32-emsisoft-emergency-kit.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-mcafee-stinger-portable/w32-mcafee-stinger-portable.myBuild install /root/.wine/drive_c/
##"${myBuildHome}"/myBuildsHost/w32-360-total-security/w32-360-total-security.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-spyhunter/w32-spyhunter.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-auslogics-disk-defrag/w32-auslogics-disk-defrag.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-event-log-observer/w32-event-log-observer.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-advanced-system-optimizer/w32-advanced-system-optimizer.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-ashampoo-winoptimizer/w32-ashampoo-winoptimizer.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-iolo-system-mechanic/w32-iolo-system-mechanic.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-razer-cortex/w32-razer-cortex.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-glary-registryrepair/w32-glary-registryrepair.myBuild install

###These did not install in wine
##"${myBuildHome}"/myBuildsHost/w32-hijack-this/w32-hijack-this.myBuild install /root/.wine/drive_c/
##"${myBuildHome}"/myBuildsHost/w32-gmer/w32-gmer.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-avast/w32-avast.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-ad-aware/w32-ad-aware.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-iobit-malware-fighter/w32-iobit-malware-fighter.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-avg/w32-avg.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-comodo-internet-security/w32-comodo-internet-security.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-malicious-software-removal-tool/w32-malicious-software-removal-tool.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-malware-bytes/w32-malware-bytes.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-vba32-rescue/w32-vba32-rescue.myBuild install #this creates a 7z file containing a raw DOS/MBR boot sector, not an executable
##"${myBuildHome}"/myBuildsHost/w32-panda-security/w32-panda-security.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-mcafee-stinger/w32-mcafee-stinger.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-kaspersky-anti-ransomware-tool/w32-kaspersky-anti-ransomware-tool.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-kaspersky-virus-removal-tool/w32-kaspersky-virus-removal-tool.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-kaspersky-tdsskiller/w32-kaspersky-tdsskiller.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-microsoft-safety-scanner/w32-microsoft-safety-scanner.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-kaspersky-tdsskiller-portable/w32-kaspersky-tdsskiller-portable.myBuild install /root/.wine/drive_c/
##"${myBuildHome}"/myBuildsHost/w32-pagedefrag/w32-pagedefrag.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-mydefrag/w32-mydefrag.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-bleachbit/w32-bleachbit.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-stellar-photo-recovery/w32-stellar-photo-recovery.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-stellar-data-recovery/w32-stellar-data-recovery.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-openhardwaremonitor/w32-openhardwaremonitor.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-cpu-z/w32-cpu-z.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-process-explorer/w32-process-explorer.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-speedfan/w32-speedfan.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-gpu-z/w32-gpu-z.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-microsoft-security-essentials/w32-microsoft-security-essentials.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-rootkit-revealer/w32-rootkit-revealer.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-iobit-advanced-systemcare/w32-iobit-advanced-systemcare.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-avira-pc-cleaner/w32-avira-pc-cleaner.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-avira-pc-optimizer/w32-avira-pc-optimizer.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-system-ninja/w32-system-ninja.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-cleanmgrplus/w32-cleanmgrplus.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-auslogics-boostspeed/w32-auslogics-boostspeed.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-wise-care-365/w32-wise-care-365.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-wise-disk-cleaner/w32-wise-disk-cleaner.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-cleanmypc/w32-cleanmypc.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-privacy-eraser/w32-privacy-eraser.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-pc-tuneup-maestro/w32-pc-tuneup-maestro.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-safesoft-pc-cleaner/w32-safesoft-pc-cleaner.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-hddscan/w32-hddscan.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-burnbytes-bin/w32-burnbytes-bin.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-comet-bin/w32-comet-bin.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-hellzerg-optimizer-bin/w32-hellzerg-optimizer-bin.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-devicedoctor/w32-devicedoctor.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-ez-pc-fix/w32-ez-pc-fix.myBuild install
##"${myBuildHome}"/myBuildsHost/w32-sysinternals/w32-sysinternals.myBuild install
