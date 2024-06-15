#!/bin/bash

git clean -f
/configure --prefix=/home/user/AndroidStudioProjects/GNUnet/distribution/zlib/lib/arm64-v8a    --shared --libdir=/home/user/AndroidStudioProjects/GNUnet/distribution/zlib/lib/arm64-v8a
make
cp cp libz.so.1.2.11 ~/AndroidStudioProjects/GNUnet/distribution/libz/lib/arm64-v8a/libz.so
cp zlib.h ~/AndroidStudioProjects/GNUnet/distribution/libz/lib/arm64-v8a/include/
