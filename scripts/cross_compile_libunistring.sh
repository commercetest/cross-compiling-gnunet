#!/bin/bash

git clean -f
./autogen.sh

./configure --host=$TARGET
make

cp ./lib/.libs/libunistring.so ~/AndroidStudioProjects/GNUnet/distribution/libunistring/lib/arm64-v8a/
cp lib/unicase.h ~/AndroidStudioProjects/GNUnet/distribution/libunistring/lib/arm64-v8a/include/
cp lib/uninorm.h ~/AndroidStudioProjects/GNUnet/distribution/libunistring/lib/arm64-v8a/include/
cp lib/unilbrk.h ~/AndroidStudioProjects/GNUnet/distribution/libunistring/lib/arm64-v8a/include/
cp lib/unigbrk.h ~/AndroidStudioProjects/GNUnet/distribution/libunistring/lib/arm64-v8a/include/
cp lib/uniwbrk.h ~/AndroidStudioProjects/GNUnet/distribution/libunistring/lib/arm64-v8a/include/
cp lib/uniwidth.h ~/AndroidStudioProjects/GNUnet/distribution/libunistring/lib/arm64-v8a/include/
cp lib/unictype.h ~/AndroidStudioProjects/GNUnet/distribution/libunistring/lib/arm64-v8a/include/
cp lib/uniname.h ~/AndroidStudioProjects/GNUnet/distribution/libunistring/lib/arm64-v8a/include/
cp lib/unistdio.h ~/AndroidStudioProjects/GNUnet/distribution/libunistring/lib/arm64-v8a/include/
cp lib/uniconv.h ~/AndroidStudioProjects/GNUnet/distribution/libunistring/lib/arm64-v8a/include/
cp lib/unistr.h ~/AndroidStudioProjects/GNUnet/distribution/libunistring/lib/arm64-v8a/include/
