# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html.
# For more examples on how to use CMake, see https://github.com/android/ndk-samples.

# Sets the minimum CMake version required for this project.
cmake_minimum_required(VERSION 3.22.1)

# Declares the project name. The project name can be accessed via ${ PROJECT_NAME},
# Since this is the top level CMakeLists.txt, the project name is also accessible
# with ${CMAKE_PROJECT_NAME} (both CMake variables are in-sync within the top level
# build script scope).
project("gnunet")

# configure import libs
set(distribution_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../../../distribution)

add_library(libgpg-error SHARED IMPORTED)
set_target_properties(libgpg-error PROPERTIES IMPORTED_LOCATION
        ${distribution_DIR}/libgpg-error/lib/${ANDROID_ABI}/libgpg-error.so)
add_library(libgcrypt SHARED IMPORTED)
set_target_properties(libgcrypt PROPERTIES IMPORTED_LOCATION
        ${distribution_DIR}/libgcrypt/lib/${ANDROID_ABI}/libgcrypt.so)
add_library(libsodium SHARED IMPORTED)
set_target_properties(libsodium PROPERTIES IMPORTED_LOCATION
        ${distribution_DIR}/libsodium/lib/${ANDROID_ABI}/libsodium.so)
add_library(libtool SHARED IMPORTED)
set_target_properties(libtool PROPERTIES IMPORTED_LOCATION
${distribution_DIR}/libtool/lib/${ANDROID_ABI}/libltdl.so)
add_library(gmp SHARED IMPORTED)
set_target_properties(gmp PROPERTIES IMPORTED_LOCATION
        ${distribution_DIR}/gmp/lib/${ANDROID_ABI}/libgmp.so)
add_library(libunistring SHARED IMPORTED)
set_target_properties(libunistring PROPERTIES IMPORTED_LOCATION
        ${distribution_DIR}/libunistring/lib/${ANDROID_ABI}/libunistring.so)
add_library(libz STATIC IMPORTED)
set_target_properties(libz PROPERTIES IMPORTED_LOCATION
        ${distribution_DIR}/libz/lib/${ANDROID_ABI}/libz.a)

# build application's shared lib
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds them for you.
# Gradle automatically packages shared libraries with your APK.
#
# In this top level CMakeLists.txt, ${CMAKE_PROJECT_NAME} is used to define
# the target library name; in the sub-module's CMakeLists.txt, ${PROJECT_NAME}
# is preferred for the same purpose.
#
# In order to load a library into your app from Java/Kotlin, you must call
# System.loadLibrary() and pass the name of the library defined here;
# for GameActivity/NativeActivity derived applications, the same library name must be
# used in the AndroidManifest.xml file.
add_library(native-lib SHARED
        # List C/C++ source files with relative paths to this CMakeLists.txt.
        native-lib.cpp)

target_include_directories(native-lib PRIVATE
        ${distribution_DIR}/libsodium/lib/${ANDROID_ABI}/include
        ${distribution_DIR}/libgcrypt/lib/${ANDROID_ABI}/include
        ${distribution_DIR}/libgpg-error/lib/${ANDROID_ABI}/include
        ${distribution_DIR}/gmp/lib/${ANDROID_ABI}/include
        ${distribution_DIR}/libunistring/lib/${ANDROID_ABI}/include
        ${distribution_DIR}/libz/lib/${ANDROID_ABI}/include
        ${distribution_DIR}/libtool/lib/${ANDROID_ABI}/include)

# Specifies libraries CMake should link to your target library. You
# can link libraries from various origins, such as libraries defined in this
# build script, prebuilt third-party libraries, or Android system libraries.
target_link_libraries(native-lib
        # List libraries link to the target library
        android
        libgpg-error
        libgcrypt
        libsodium
        libtoolmeson build
        gmp
        libunistring
        libz
        log)