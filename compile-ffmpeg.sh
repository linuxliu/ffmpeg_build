#! /usr/bin/env bash
#author: liuhaiqiang@ajmide.com

#----------
UNI_BUILD_ROOT=`pwd`
FF_TARGET=$1
FF_TARGET_EXTRA=$2
set -e
set +x

FF_ACT_ARCHS_ALL="armv5 armv7a arm64 x86 x86_64"
LIB_NAME="ffmpeg-4.0.3"
if [ ! -f "${LIB_NAME}.tar.gz" ];then
    wget https://ffmpeg.org/releases/${LIB_NAME}.tar.gz;
    tar -zxvf "${LIB_NAME}.tar.gz" -C ./
    for ARCH in $FF_ACT_ARCHS_ALL
    do
        if [ -d ffmpeg-$ARCH ]; then
            rm -rf  ffmpeg-$ARCH
        fi
        cp -rf "${LIB_NAME}" ffmpeg-$ARCH
    done
fi

echo_usage() {
    echo "Usage:"
    echo "  compile-ffmpeg.sh armv5|armv7a|arm64|x86|x86_64"
    echo "  compile-ffmpeg.sh all"
    echo "  compile-ffmpeg.sh clean"
    echo ""
    exit 1
}

#----------
case "$FF_TARGET" in
    "")
        echo_archs armv7a
        sh do-compile-ffmpeg.sh armv7a
    ;;
    armv5|armv7a|arm64|x86|x86_64)
        sh do-compile-ffmpeg.sh $FF_TARGET $FF_TARGET_EXTRA
    ;;
    all)
        for ARCH in $FF_ACT_ARCHS_ALL
        do
            sh do-compile-ffmpeg.sh $ARCH $FF_TARGET_EXTRA
        done
    ;;
    clean)
        for ARCH in $FF_ACT_ARCHS_ALL
        do
            if [ -d ffmpeg-$ARCH ]; then
                cd ffmpeg-$ARCH && make clean && cd -
            fi
        done
        rm -rf ./build/ffmpeg-*
    ;;
    *)
        echo_usage
        exit 1
    ;;
esac
