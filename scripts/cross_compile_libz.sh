#!/bin/bash

git clean -f
./configure
make
cp ./libz.a ~/AndroidStudioProjects/GNUnet/distribution/libz/lib/arm64-v8a/
cp zlib.h ~/AndroidStudioProjects/GNUnet/distribution/libz/lib/arm64-v8a/include/
