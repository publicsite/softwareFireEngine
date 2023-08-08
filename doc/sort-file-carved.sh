#!/bin/sh

if [ "$1" = "" ]; then
echo "Arg 1: source dir"
exit
fi

if [ "$2" = "" ]; then
echo "Arg 2: dest dir"
exit
fi 

find "$1" -type f | while read afile; do
extension="$(echo "$afile" | rev | cut -d '.' -f 1 | rev)"
extensionLower="$(printf "%s" "$extension" | tr "[:upper:]" "[:lower:]")"

if [ "$extensionLower" = "3gp" ] || [ "$extensionLower" = "aa" ] || [ "$extensionLower" = "aac" ] || [ "$extensionLower" = "aax" ] || [ "$extensionLower" = "act" ] || [ "$extensionLower" = "aiff" ] || [ "$extensionLower" = "alac" ] || [ "$extensionLower" = "amr" ] || [ "$extensionLower" = "ape" ] || [ "$extensionLower" = "au" ] || [ "$extensionLower" = "awb" ] || [ "$extensionLower" = "dss" ] || [ "$extensionLower" = "dvf" ] || [ "$extensionLower" = "flac" ] || [ "$extensionLower" = "gsm" ] || [ "$extensionLower" = "iklax" ] || [ "$extensionLower" = "ivs" ] || [ "$extensionLower" = "m4a" ] || [ "$extensionLower" = "m4b" ] || [ "$extensionLower" = "m4p" ] || [ "$extensionLower" = "mmf" ] || [ "$extensionLower" = "mp3" ] || [ "$extensionLower" = "mpc" ] || [ "$extensionLower" = "msv" ] || [ "$extensionLower" = "nmf" ] || [ "$extensionLower" = "ogg" ] || [ "$extensionLower" = "oga" ] || [ "$extensionLower" = "mogg" ] || [ "$extensionLower" = "opus" ] || [ "$extensionLower" = "ra" ] || [ "$extensionLower" = "rm" ] || [ "$extensionLower" = "raw" ] || [ "$extensionLower" = "rf64" ] || [ "$extensionLower" = "sln" ] || [ "$extensionLower" = "tta" ] || [ "$extensionLower" = "voc" ] || [ "$extensionLower" = "vox" ] || [ "$extensionLower" = "wav" ] || [ "$extensionLower" = "wma" ] || [ "$extensionLower" = "wv" ] || [ "$extensionLower" = "webm" ] || [ "$extensionLower" = "8svx" ] || [ "$extensionLower" = "cda" ]; then
#audio
	echo "$afile"
	theprobe="$(ffprobe -loglevel 0 -print_format json -show_format "$afile")"

	title="$(printf "%s" "$theprobe" | grep "\"title\": \"" | rev | cut -d '"' -f 2 | rev | tr -d '*' | tr -d '?' | tr -d '/' | tr -d '\0')"
	artist="$(printf "%s" "$theprobe" | grep "\"artist\": \"" | rev | cut -d '"' -f 2 | rev | tr -d '*' | tr -d '?' | tr -d '/' | tr -d '\0')"
	album="$(printf "%s" "$theprobe" | grep "\"album\": \"" | rev | cut -d '"' -f 2 | rev | tr -d '*' | tr -d '?' | tr -d '/' | tr -d '\0')"
	if [ "$artist" = "" ]; then
		artist="Unknown Artist"
	fi

	if [ "$album" = "" ]; then
		album="Unknown Album"
	fi

	mkdir -p "${2}/audio/${artist}/${album}"

	if [ "${title}" = "" ]; then
		sudo mv "${afile}" "${2}/audio/${artist}/${album}/"
	else
		sudo mv "${afile}" "${2}/audio/${artist}/${album}/${title}.${extension}"
	fi
elif [ "$extensionLower" = "webm" ] || [ "$extensionLower" = "mkv" ] || [ "$extensionLower" = "flv" ] || [ "$extensionLower" = "vob" ] || [ "$extensionLower" = "ogv" ] || [ "$extensionLower" = "ogg" ] || [ "$extensionLower" = "drc" ] || [ "$extensionLower" = "gif" ] || [ "$extensionLower" = "gifv" ] || [ "$extensionLower" = "mng" ] || [ "$extensionLower" = "avi" ] || [ "$extensionLower" = "mts" ] || [ "$extensionLower" = "m2ts" ] || [ "$extensionLower" = "ts" ] || [ "$extensionLower" = "mov" ] || [ "$extensionLower" = "qt" ] || [ "$extensionLower" = "wmv" ] || [ "$extensionLower" = "yuv" ] || [ "$extensionLower" = "rm" ] || [ "$extensionLower" = "rmvb" ] || [ "$extensionLower" = "viv" ] || [ "$extensionLower" = "asf" ] || [ "$extensionLower" = "amv" ] || [ "$extensionLower" = "mp4" ] || [ "$extensionLower" = "m4p" ] || [ "$extensionLower" = "m4v" ] || [ "$extensionLower" = "mpg" ] || [ "$extensionLower" = "mp2" ] || [ "$extensionLower" = "mpeg" ] || [ "$extensionLower" = "mpe" ] || [ "$extensionLower" = "mpv" ] || [ "$extensionLower" = "mpg" ] || [ "$extensionLower" = "mpeg" ] || [ "$extensionLower" = "m2v" ] || [ "$extensionLower" = "m4v" ] || [ "$extensionLower" = "svi" ] || [ "$extensionLower" = "3gp" ] || [ "$extensionLower" = "3g2" ] || [ "$extensionLower" = "mxf" ] || [ "$extensionLower" = "roq" ] || [ "$extensionLower" = "nsv" ] || [ "$extensionLower" = "f4v" ] || [ "$extensionLower" = "f4p" ] || [ "$extensionLower" = "f4a" ] || [ "$extensionLower" = "f4b" ]; then
#video
	mkdir -p "${2}/video/${extensionLower}"
	sudo mv "${afile}" "${2}/video/${extensionLower}/"
elif [ "$extensionLower" = "jpeg" ] || [ "$extensionLower" = "jpg" ] || [ "$extensionLower" = "jfif" ] || [ "$extensionLower" = "exif" ] || [ "$extensionLower" = "tiff" ] || [ "$extensionLower" = "png" ] || [ "$extensionLower" = "iff-meta" ] || [ "$extensionLower" = "gif" ] || [ "$extensionLower" = "bmp" ] || [ "$extensionLower" = "mng" ] || [ "$extensionLower" = "apng" ] || [ "$extensionLower" = "ppm" ] || [ "$extensionLower" = "pgm" ] || [ "$extensionLower" = "pbm" ] || [ "$extensionLower" = "pnm" ] || [ "$extensionLower" = "webp" ] || [ "$extensionLower" = "xmp" ] || [ "$extensionLower" = "jpeg-hdr" ] || [ "$extensionLower" = "jpeg-xt" ] || [ "$extensionLower" = "heif" ] || [ "$extensionLower" = "hevc" ] || [ "$extensionLower" = "avif" ] || [ "$extensionLower" = "av1" ] || [ "$extensionLower" = "jpeg-xl" ] || [ "$extensionLower" = "jpeg-xr" ] || [ "$extensionLower" = "bpg" ] || [ "$extensionLower" = "deep" ] || [ "$extensionLower" = "iff" ] || [ "$extensionLower" = "drw" ] || [ "$extensionLower" = "ecw" ] || [ "$extensionLower" = "fits" ] || [ "$extensionLower" = "flif" ] || [ "$extensionLower" = "ico" ] || [ "$extensionLower" = "ilbm" ] || [ "$extensionLower" = "img" ] || [ "$extensionLower" = "gem" ] || [ "$extensionLower" = "nrrd" ] || [ "$extensionLower" = "pam" ] || [ "$extensionLower" = "pcx" ] || [ "$extensionLower" = "pgf" ] || [ "$extensionLower" = "plbm" ] || [ "$extensionLower" = "sgi" ] || [ "$extensionLower" = "sid" ] || [ "$extensionLower" = "tga" ] || [ "$extensionLower" = "targa" ] || [ "$extensionLower" = "vicar" ] || [ "$extensionLower" = "jpl" ] || [ "$extensionLower" = "xisf" ] || [ "$extensionLower" = "cd5" ] || [ "$extensionLower" = "clip" ] || [ "$extensionLower" = "cpt" ] || [ "$extensionLower" = "kra" ] || [ "$extensionLower" = "mdp" ] || [ "$extensionLower" = "pdn" ] || [ "$extensionLower" = "psd" ] || [ "$extensionLower" = "psp" ] || [ "$extensionLower" = "sai" ] || [ "$extensionLower" = "xcf" ]; then
#image raster
	mkdir -p "${2}/images/raster/${extensionLower}"
	sudo mv "${afile}" "${2}/images/raster/${extensionLower}/"
elif [ "$extensionLower" = "cgm" ] || [ "$extensionLower" = "sgv" ] || [ "$extensionLower" = "dxf" ] || [ "$extensionLower" = "gerber" ] || [ "$extensionLower" = "afdesign" ] || [ "$extensionLower" = "ai" ] || [ "$extensionLower" = "cdr" ] || [ "$extensionLower" = "!draw" ] || [ "$extensionLower" = "drawingml" ] || [ "$extensionLower" = "gem" ] || [ "$extensionLower" = "gle" ] || [ "$extensionLower" = "hp-gl" ] || [ "$extensionLower" = "hvif" ] || [ "$extensionLower" = "lottie" ] || [ "$extensionLower" = "mathml" ] || [ "$extensionLower" = "naplps" ] || [ "$extensionLower" = "odg" ] || [ "$extensionLower" = "pgml" ] || [ "$extensionLower" = "pstricks" ] || [ "$extensionLower" = "pgf" ] || [ "$extensionLower" = "tikz" ] || [ "$extensionLower" = "qcc" ] || [ "$extensionLower" = "regis" ] || [ "$extensionLower" = "rip" ] || [ "$extensionLower" = "vml" ] || [ "$extensionLower" = "xar" ] || [ "$extensionLower" = "xps" ]; then
#image vector
	mkdir -p "${2}/images/vector/${extensionLower}"
	sudo mv "${afile}" "${2}/images/vector/${extensionLower}/"
elif [ "$extensionLower" = "accdb" ] || [ "$extensionLower" = "ai" ] || [ "$extensionLower" = "apr" ] || [ "$extensionLower" = "csv" ] || [ "$extensionLower" = "cwk" ] || [ "$extensionLower" = "doc" ] || [ "$extensionLower" = "docx" ] || [ "$extensionLower" = "et" ] || [ "$extensionLower" = "fb2" ] || [ "$extensionLower" = "fods" ] || [ "$extensionLower" = "fp7" ] || [ "$extensionLower" = "fp12" ] || [ "$extensionLower" = "gnucash" ] || [ "$extensionLower" = "kmy" ] || [ "$extensionLower" = "lyx" ] || [ "$extensionLower" = "mdb" ] || [ "$extensionLower" = "njx" ] || [ "$extensionLower" = "odg" ] || [ "$extensionLower" = "odp" ] || [ "$extensionLower" = "ods" ] || [ "$extensionLower" = "odt" ] || [ "$extensionLower" = "one" ] || [ "$extensionLower" = "pages" ] || [ "$extensionLower" = "pap" ] || [ "$extensionLower" = "ppt" ] || [ "$extensionLower" = "pptx" ] || [ "$extensionLower" = "pub" ] || [ "$extensionLower" = "qbb" ] || [ "$extensionLower" = "qbw" ] || [ "$extensionLower" = "qpw" ] || [ "$extensionLower" = "rtf" ] || [ "$extensionLower" = "sda" ] || [ "$extensionLower" = "sdc" ] || [ "$extensionLower" = "sdd" ] || [ "$extensionLower" = "sdw" ] || [ "$extensionLower" = "slk" ] || [ "$extensionLower" = "sav" ] || [ "$extensionLower" = "snt" ] || [ "$extensionLower" = "sxc" ] || [ "$extensionLower" = "sxd" ] || [ "$extensionLower" = "sxi" ] || [ "$extensionLower" = "sxw" ] || [ "$extensionLower" = "tex" ] || [ "$extensionLower" = "txt" ] || [ "$extensionLower" = "vsd" ] || [ "$extensionLower" = "vsdx" ] || [ "$extensionLower" = "wpd" ] || [ "$extensionLower" = "wps" ] || [ "$extensionLower" = "xlr" ] || [ "$extensionLower" = "xls" ] || [ "$extensionLower" = "xlsx" ] || [ "$extensionLower" = "wdb" ] || [ "$extensionLower" = "wk4" ] || [ "$extensionLower" = "wks" ]; then
#document format
	mkdir -p "${2}/documents/${extensionLower}"
	sudo mv "${afile}" "${2}/documents/${extensionLower}/"
elif [ "$extensionLower" = "amf" ] || [ "$extensionLower" = "asymptote" ] || [ "$extensionLower" = "blend" ] || [ "$extensionLower" = "collada" ] || [ "$extensionLower" = "dgn" ] || [ "$extensionLower" = "dwf" ] || [ "$extensionLower" = "dwg" ] || [ "$extensionLower" = "dxf" ] || [ "$extensionLower" = "edrawings" ] || [ "$extensionLower" = "flt" ] || [ "$extensionLower" = "fvrml" ] || [ "$extensionLower" = "fx3d" ] || [ "$extensionLower" = "x3d" ] || [ "$extensionLower" = "vrml" ] || [ "$extensionLower" = "gltf" ] || [ "$extensionLower" = "hsf" ] || [ "$extensionLower" = "iges" ] || [ "$extensionLower" = "imml" ] || [ "$extensionLower" = "ipa" ] || [ "$extensionLower" = "jt" ] || [ "$extensionLower" = "ma" ] || [ "$extensionLower" = "mb" ] || [ "$extensionLower" = "obj" ] || [ "$extensionLower" = "opengex" ] || [ "$extensionLower" = "ply" ] || [ "$extensionLower" = "pov-ray" ] || [ "$extensionLower" = "prc" ] || [ "$extensionLower" = "step" ] || [ "$extensionLower" = "skp" ] || [ "$extensionLower" = "stl" ] || [ "$extensionLower" = "u3d" ] || [ "$extensionLower" = "vrml" ] || [ "$extensionLower" = "xaml" ] || [ "$extensionLower" = "xgl" ] || [ "$extensionLower" = "xvl" ] || [ "$extensionLower" = "xvrml" ] || [ "$extensionLower" = "3d" ] || [ "$extensionLower" = "3df" ] || [ "$extensionLower" = "3dm" ] || [ "$extensionLower" = "3ds" ] || [ "$extensionLower" = "3dxml" ] || [ "$extensionLower" = "x3d" ]; then
#image 3d vector
	mkdir -p "${2}/images/3d-vector/${extensionLower}"
	sudo mv "${afile}" "${2}/images/3d-vector/${extensionLower}/"
elif [ "$extensionLower" = "eps" ] || [ "$extensionLower" = "pdf" ] || [ "$extensionLower" = "postscript" ] || [ "$extensionLower" = "ps" ] || [ "$extensionLower" = "pict" ] || [ "$extensionLower" = "wmf" ] || [ "$extensionLower" = "emf" ] || [ "$extensionLower" = "swf" ] || [ "$extensionLower" = "xaml" ]; then
#image compound
	mkdir -p "${2}/images/compound/${extensionLower}"
	sudo mv "${afile}" "${2}/images/compound/${extensionLower}/"
elif [ "$extensionLower" = "mpo" ] || [ "$extensionLower" = "pns" ] || [ "$extensionLower" = "jps" ]; then
#image stereo
	mkdir -p "${2}/images/stereo/${extensionLower}"
	sudo mv "${afile}" "${2}/images/stereo/${extensionLower}/"
elif [ "$extensionLower" = "7z" ] || [ "$extensionLower" = "a" ] || [ "$extensionLower" = "ace" ] || [ "$extensionLower" = "apk" ] || [ "$extensionLower" = "arj" ] || [ "$extensionLower" = "bkf" ] || [ "$extensionLower" = "bz2" ] || [ "$extensionLower" = "cab" ] || [ "$extensionLower" = "dar" ] || [ "$extensionLower" = "deb" ] || [ "$extensionLower" = "dump" ] || [ "$extensionLower" = "ghx" ] || [ "$extensionLower" = "gz" ] || [ "$extensionLower" = "lzh" ] || [ "$extensionLower" = "lzo" ] || [ "$extensionLower" = "par2" ] || [ "$extensionLower" = "rar" ] || [ "$extensionLower" = "rpm" ] || [ "$extensionLower" = "stu" ] || [ "$extensionLower" = "tar" ] || [ "$extensionLower" = "tar.gz" ] || [ "$extensionLower" = "vbm" ] || [ "$extensionLower" = "wim" ] || [ "$extensionLower" = "xar" ] || [ "$extensionLower" = "xz" ] || [ "$extensionLower" = "zip" ]; then
#archive format
	mkdir -p "${2}/archives/${extensionLower}"
	sudo mv "${afile}" "${2}/archives/${extensionLower}/"

else
	mkdir -p "${2}/unknown-format/${extensionLower}" 
	sudo mv "${afile}" "${2}/unknown-format/${extensionLower}/"
fi
done

theuser="$(whoami)"

sudo chown -R ${theuser}:${theuser} "${2}"
