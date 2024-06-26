#!/bin/bash

git clean -f
./autogen.sh

cp /home/user/Documents/gnunet_stuff/libgcrypt/m4/gpg-error.m4 m4/
cp /home/user/Documents/gnunet_stuff/libgcrypt/src&libgcrypt.vers src/
./configure --host=$TARGET --with-libgpg-error-prefix=/home/user/Documents/libgpg-error/cross-build/ --disable-doc
make

cp ./src/.libs/libgcrypt.so ~/AndroidStudioProjects/GNUnet/distribution/libgcrypt/lib/arm64-v8a/
cp ./src/gcrypt.h ~/AndroidStudioProjects/GNUnet/distribution/libgcrypt/lib/arm64-v8a/include/
