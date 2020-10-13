#!/bin/bash

VERSION=$1

check() {
    prefix=${VERSION%%.*}
    curl --head "https://github.com/RayJiang16/iOSDeviceSupport/raw/main/DeviceSupport/iOS$prefix/$VERSION.zip" | head -n 3 | grep "HTTP/1.[01] 404"
}

if [ ${#VERSION} == 0 ]; then
    read -p "Enter version you want to download:" VERSION
fi

cd /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport

if [ -d $VERSION ]; then
    echo "\033[32mVersion $VERSION already exists\033[0m"
    exit 0
fi

if check; then
    echo "\033[31mVersion $VERSION dosen't exists\033[0m"
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
