# cross-compiling-gnunet
A work-in-progress repository of the scripts, discoveries, tips and traps we're discovering during the process of cross-compiling GNUnet for Android.

# Dependencies for GNUnet Utils
| Libraries | Source of Library | Version | How built | Local location on build machine |
| -------- | -------- | -------- |  -------- | -------- |
| liblibsodium| Text     | Text     | Text     | Text     |
| libgcrypt| Text     | Text     | Text     | Text     |
| lltdl| Text     | Text     | Text     | Text     |
| unistring| https://github.com/gnosis/libunistring     | HEAD     | Text     | ~/x-compile-gnunet-sandbox/libunistring-for-android     |
| gmp| Text     | Text     | Text     | Text     |
| zlib| Text     | Text     | Text     | Text     |

(The table is reproduced from https://hedgedoc.c3d2.de/4_Gov7XPT9yE3JHfiTH8nQ?view)
# Related Work

- Environment variables are set using the examples in the Autoconf section of https://developer.android.com/ndk/guides/other_build_systems
- https://github.com/commercetest/libgpg-error-with-android/tree/updates-to-build-for-android documents specific steps for building on/for Android devices

# Licenses for this work
The code is currently available under the [MIT license](https://github.com/commercetest/cross-compiling-gnunet?tab=MIT-1-ov-file#readme) and text available under the [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) license. For the avoidance of doubt any portion of this material may be incorporated into projects licensed with an approved GNU GPL license (see https://www.gnu.org/licenses/gpl-howto.html).
