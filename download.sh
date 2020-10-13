#!/bin/bash

VERSION=$1
VERSION_LIST=("13.0" "13.1" "13.2" "13.3" "13.4" "13.5" "13.6" "13.7" "14.0")

printVersion() {
    i=0
    count=${#VERSION_LIST[*]}
    while (( i < count )); do
        left=${VERSION_LIST[i]}
        ((i++))
        if (( i < count )); then
            right=${VERSION_LIST[i]}
            ((i++))
            echo "$left\t$right"
        else
            echo "$left"
        fi
    done
}

if [ ${#VERSION} == 0 ]; then
    printVersion
    read -p "Enter version you want to download:" VERSION
fi

cd /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport

if [[ ! " ${VERSION_LIST[@]} " =~ " ${VERSION} " ]]; then
    echo "\033[31mVersion $VERSION dosen't exists\033[0m"
    exit 0
fi

if [ -d $VERSION ]; then
    echo "\033[32mVersion $VERSION already exists\033[0m"
    exit 0
fi

prefix=${VERSION%%.*}
download_url="https://github.com/RayJiang16/iOSDeviceSupport/raw/main/DeviceSupport/iOS$prefix/$VERSION.zip"
curl -L -O $download_url

if [ ! -f "$VERSION.zip" ]; then
    echo "\033[31mFailed download Version $VERSION\033[0m"
    exit 0
fi

unzip "$VERSION.zip"
rm -f "$VERSION.zip"
open ./

echo "\033[32mSuccessful download Version $VERSION\033[0m"
