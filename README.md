# cross-compiling-gnunet
A work-in-progress repository of the scripts, discoveries, tips and traps we're discovering during the process of cross-compiling GNUnet for Android.

This repo contains a set of scripts in https://github.com/commercetest/cross-compiling-gnunet/tree/main/scripts which we are iteratively refining.

# Dependencies for GNUnet Utils
| Libraries | Source of Library | Version | How built | Local location on build machine | Evidence |
| -------- | -------- | -------- |  -------- | -------- | -------- |
| liblibsodium| Text     | Text     | Text     | Text     | Text     |
| libgcrypt| Text     | Text     | Text     | Text     | Text     |
| lltdl| [Text](https://git.savannah.gnu.org/git/libtool.git)     | HEAD     | Text     | ~/x-compile-gnunet-sandbox/libtool-for-android     | file libltdl/.libs/libltdl.so   |
| unistring| https://github.com/gnosis/libunistring     | HEAD     | Text     | ~/x-compile-gnunet-sandbox/libunistring-for-android     | `file ./lib/.libs/libunistring.so` |
| gmp| [Text](https://gmplib.org/devel/repo-usage)     | 6.2     | Text     | ~/x-compile-gnunet-sandbox/gmp-6_2_for_android     | Text     |
| zlib| Text     | Text     | Text     | Text     | Text     |

(The table is an extended edition of https://hedgedoc.c3d2.de/4_Gov7XPT9yE3JHfiTH8nQ?view)

The evidence column provides a summary of how to check whether the results are OK. Generally the output of the file command will include the intended architecture of the library|libraries that were generated.

## lltdl
```
git clone https://git.savannah.gnu.org/git/libtool.git libtool-for-android
cd libtool-for-android/
./bootstrap
./configure --host=$TARGET
make

file libltdl/.libs/libltdl.so
file 
```

## libunistring
```
git clone ...
# Configure environment variables
./gitsub.sh pull
./autogen.sh 
./configure --host=$TARGET
make

file ./lib/.libs/libunistring.so
file libltdl/ltdl.h
```
## software packages needed to build the dependencies
YMMV depending on what your development environment and OS release already provide. To help improve reproducibility here are packages that needed installing to make these dependencies.

- `hg` (mercurial) and `yacc` needed to make gmp. In Ubuntu 22.04 LTS these were provided using `sudo apt install mercurial bison`.
- `gperf` installed using `sudo apt install gperf`
- `help2man` installed using `sudo apt install help2man`

# Related Work

- Environment variables are set using the examples in the Autoconf section of https://developer.android.com/ndk/guides/other_build_systems
- https://github.com/commercetest/libgpg-error-with-android/tree/updates-to-build-for-android documents specific steps for building on/for Android devices

# Licenses for this work
The code is currently available under the [MIT license](https://github.com/commercetest/cross-compiling-gnunet?tab=MIT-1-ov-file#readme) and text available under the [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) license. For the avoidance of doubt any portion of this material may be incorporated into projects licensed with an approved GNU GPL license (see https://www.gnu.org/licenses/gpl-howto.html).
