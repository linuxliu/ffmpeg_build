#! /usr/bin/env bash
# author liuhaiqiang@ajmide.com
#b
#----------


UNI_BUILD_ROOT=`pwd`
FF_TARGET=$1
set -e
set +x




FF_ACT_ARCHS_ALL="armv5 armv7a arm64 x86 x86_64"
LIB_NAME="openssl-1.0.2p"
if [ ! -f "${LIB_NAME}.tar.gz" ];then
    wget https://www.openssl.org/source/${LIB_NAME}.tar.gz;
    tar -zxvf "${LIB_NAME}.tar.gz" -C ./
    for ARCH in $FF_ACT_ARCHS_ALL
    do
        if [ -d openssl-$ARCH ]; then
            rm -rf  openssl-$ARCH
        fi
        cp -rf "${LIB_NAME}" openssl-$ARCH
    done
fi
echo_usage() {
    echo "Usage:"
    echo "  compile-openssl.sh armv5|armv7a|arm64|x86|x86_64"
    echo "  compile-openssl.sh all"
    echo "  compile-openssl.sh clean"
    echo ""
    exit 1
}



#----------
case "$FF_TARGET" in
    "")
        sh do-compile-openssl.sh armv7a
    ;;
    armv5|armv7a|arm64|x86|x86_64)
        sh do-compile-openssl.sh $FF_TARGET
    ;;
    all)
        for ARCH in $FF_ACT_ARCHS_ALL
        do
            sh do-compile-openssl.sh $ARCH
        done
    ;;
    clean)
        for ARCH in $FF_ACT_ARCHS_ALL
        do
            if [ -d openssl-$ARCH ]; then
                cd openssl-$ARCH && make clean && cd -
            fi
        done
        rm -rf ./build/openssl-*
    ;;
    *)
        echo_usage
        exit 1
    ;;
esac
