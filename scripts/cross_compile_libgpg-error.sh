#!/bin/bash

git clean -f
./autogen.sh
build="$(build-aux/config.guess)"
./configure --enable-maintainer-mode -prefix=$TARGETDIR --host=$TARGET --build=$build --disable-doc

# This commented part has to be done once. The generated file can be reused.
#cd src
#make gen-posix-lock-obj
#emulator -no-window -writable-system -avd Pixel8API25v8
#adb -s emulator-5554 -e push ~/Downloads/gen-posix-lock-obj /data/local/tmp
#adb -s emulator-5554 shell /data/local/tmp/gen-posix-lock-obj > tmp.h
#adb -s emulator-5554 emu kill
#mv tmp.h "syscfg/$(awk 'NR==1 {print $2}' tmp.h)"
#cd ..
# TODO Copy the once already generated header from elsewhere to directory syscfg.

make
cp src/gpg-error-config cross-build/bin/
cp src/gpgrt-config cross-build/bin/
cp src/.libs/libgpg-error.so cross-build/lib/
cp src/gpg-error.h cross-build/include/gpg-error.h

cp src/.libs/libgpg-error.so ~/AndroidStudioProjects/GNUnet/distribution/libgpg-error/lib/arm64-v8a/
cp libltdl/ltdl.h ~/AndroidStudioProjects/GNUnet/distribution/libgpg-error/lib/arm64-v8a/include/

