# cross-compiling-gnunet
A work-in-progress repository of the scripts, discoveries, tips and traps we're discovering during the process of cross-compiling GNUnet for Android.

This repo contains a set of scripts in https://github.com/commercetest/cross-compiling-gnunet/tree/main/scripts which we are iteratively refining.

Key elements:

- root folder for the cross-compilation; set to `~/x-compile-gnunet-sandbox` for now
- root folder for the target architecture's binaries that Android's build system uses that is mapped using `CMakeLists.txt`
- inter-dependencies folder, which contains various folders for intermediate build outputs used by other dependencies.

# Dependencies for GNUnet Utils
| Libraries | Source of Library | Version | How built | Local location on build machine | Evidence |
| -------- | -------- | -------- |  -------- | -------- | -------- |
| liblibsodium| Text     | Text     | Text     | Text     | Text     |
| libgpg-error | [fork of github-mirror](https://github.com/commercetest/libgpg-error-with-android.git ) | 1.49 | Text | ~/x-compile-gnunet-sandbox/libgpg-error-with-android | file ./src/.libs/libgpg-error.so |
| libgcrypt| https://github.com/gpg/libgcrypt.git     | 1.10.3     | Text     | Text     | Text     |
| lltdl| https://git.savannah.gnu.org/git/libtool.git    | HEAD     | Text     | ~/x-compile-gnunet-sandbox/libtool-for-android     | `file libltdl/.libs/libltdl.so`   |
| unistring| https://github.com/gnosis/libunistring     | HEAD     | Text     | ~/x-compile-gnunet-sandbox/libunistring-for-android     | `file ./lib/.libs/libunistring.so` |
| gmp| https://gmplib.org/devel/repo-usage   | 6.2     | Text     | ~/x-compile-gnunet-sandbox/gmp-6_2_for_android     | `file ./.libs/libgmp.so`     |
| zlib| Text     | Text     | Text     | Text     | Text     |

(The table is an extended edition of https://hedgedoc.c3d2.de/4_Gov7XPT9yE3JHfiTH8nQ?view)

The evidence column provides a summary of how to check whether the results are OK. Generally the output of the file command will include the intended architecture of the library|libraries that were generated.

## Shared folders for inter-dependencies
`libgpg-error` generates various files used by `libgcrypt`. A set of shared folders are created in the root of the cross-compilation root `~/x-compile-gnunet-sandbox/`
```
mkdir ~/x-compile-gnunet-sandbox/cross-build/
mkdir ~/x-compile-gnunet-sandbox/cross-build/bin
mkdir ~/x-compile-gnunet-sandbox/cross-build/include
mkdir ~/x-compile-gnunet-sandbox/cross-build/lib
```

## libgpg-error (used by libgcrypt, so build first)
```
# For whatever reason this folder needs to exist for make to complete the build
mkdir targetdir
export TARGETDIR=`pwd`/targetdir
echo $TARGETDIR

# standard build steps
./autogen.sh 
build="$(build-aux/config.guess)"
./configure --enable-maintainer-mode -prefix=$TARGETDIR --host=$TARGET --build=$build --disable-doc
```
The following steps only need to be performed once per architecture. You will need a suitable physical Android device, or emulator, for each target Android architecture.
```
cd src
make gen-posix-lock-obj

# discover which Android devices (emulators and/or physical devices) are available to use
adb devices

# from the list of devices, pick the serial number and use it in the rest of the steps that use adb
# Obtain the Android architecture
adb -s FRTBB80301420573  shell getprop ro.product.cpu.abi

# Transfer the script that will generate the architecture specific header file
adb -s FRTBB80301420573 push gen-posix-lock-obj /data/local/tmp

# adb shell is similar to an SSH session
adb -s FRTBB80301420573 shell

# After closing the adb shell, retrieve the generated header file
adb -s FRTBB80301420573 pull /data/local/tmp/tmp.h .

# This is a debugging step
awk 'NR==1 {print $2}' tmp.h
# followed by renaming and relocating the file using the contents of the first line 
mv tmp.h "syscfg/$(awk 'NR==1 {print $2}' tmp.h)"

# As the generated file on Android includes some extraneous information 
# the file name isn't as expected; so we make a copy to a suitable name
cd syscfg/
ls -lart  # check the most recent file is the renamed tmp.h

# Remove the architecture-specific element from the name of the header file
cp lock-obj-pub.armv7a-unknown-linux-androideabi.h lock-obj-pub.linux-android.h
```
Each make continues from here (the Android stuff only needs doing once per Android architecture).
Beware of accidentially using the wrong architecture specific header file (generated in the previous steps).
```
# Continue the standard make process
cd ../..
make

# Check the generated shared library is for the expected Android architecture
file ./src/.libs/libgpg-error.so
```

## gmp
```
hg outgoing # check for any uncommitted changes to the cloned repo

./.bootstrap
./configure --host=$TARGET --enable-maintainer-mode

file gmp.h| grep 'C source'
echo $?  # should be 0

file ./.libs/libgmp.so  | grep 'ARM aarch64'
echo $?  # should be 0
```

## libgcrypt
We're currently building release 1.10.3 and make some changes to the configuration; TBD how long-lived these will be.
```
git checkout libgcrypt-1.10.3
```

## libunistring
```
git clone ...
# Configure environment variables
./gitsub.sh pull
./autogen.sh 
./configure --host=$TARGET
make

file ./lib/.libs/libunistring.so | grep 'ARM aarch64'
echo $?  # should be 0

file libltdl/ltdl.h | grep 'C source'
echo $?  # should be 0
```

## lltdl
```
git clone https://git.savannah.gnu.org/git/libtool.git libtool-for-android
cd libtool-for-android/
./bootstrap
./configure --host=$TARGET
make

file libltdl/.libs/libltdl.so | grep 'ARM aarch64'
echo $?  # should be 0

file libltdl/ltdl.h | grep 'C source'
echo $?  # should be 0
```

## software packages needed to build the dependencies
YMMV depending on what your development environment and OS release already provide. To help improve reproducibility here are packages that needed installing to make these dependencies.

- `hg` (mercurial) and `yacc` needed to make gmp. In Ubuntu 22.04 LTS these were provided using `sudo apt install mercurial bison`.
- `gperf` installed using `sudo apt install gperf`
- `help2man` installed using `sudo apt install help2man`

# Related Work

- Environment variables are set using the examples in the Autoconf section of https://developer.android.com/ndk/guides/other_build_systems
- https://github.com/commercetest/libgpg-error-with-android/tree/updates-to-build-for-android documents specific steps for building on/for Android devices
- https://www.repeato.app/determining-the-arm-processor-version-on-your-android-device/ and https://android.stackexchange.com/questions/188725/determine-device-architecture-arm-arm64-x86-with-adb-getprop on obtaining the ABI (Android architecture) supported by an Android device.

# Licenses for this work
The code is currently available under the [MIT license](https://github.com/commercetest/cross-compiling-gnunet?tab=MIT-1-ov-file#readme) and text available under the [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) license. For the avoidance of doubt any portion of this material may be incorporated into projects licensed with an approved GNU GPL license (see https://www.gnu.org/licenses/gpl-howto.html).
