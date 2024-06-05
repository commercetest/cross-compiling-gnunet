git clean -f
./bootstrap
. ./cross_compile_config.sh $1 $2
./configure --host=$TARGET
make
cp ./libltdl/.libs/libltdl.so ~/AndroidStudioProjects/GNUnet/distribution/libtool/lib/arm64-v8a/
cp libltdl/ltdl.h ~/AndroidStudioProjects/GNUnet/distribution/libtool/lib/arm64-v8a/include/
