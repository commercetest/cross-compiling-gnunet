#!/bin/bash

# This script needs to be called with the target architecture and the Android API level as parameters.
# TODO Third parameter for Android NDK path.

if [ "$#" -ne 4 ]
then
  echo "Incorrect number of arguments"
  echo expected 4 parameters: TARGET API NDK_PATH ANDROID_ABI
  echo e.g. source $0 aarch64-linux-android 33 /home/julian/android-studio/ndk/25.1.8937393/ arm64-v8a
  echo see https://developer.android.com/ndk/guides/other_build_systems and https://developer.android.com/ndk/guides/abis#sa for details on these values.
  echo This script MUST be called with source, or similar, for the environment variables to be set in your shell environment.
  exit 1
fi

echo debugging info: 4 lines should follow with each of the 4 parameters in turn.
echo $1
echo $2
echo $3
echo $4

export TARGET=$1
export API=$2
export NDK=$3
export ANDROIDABI=$4

export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip

echo Please check that the various environment variables have been set in your shell.