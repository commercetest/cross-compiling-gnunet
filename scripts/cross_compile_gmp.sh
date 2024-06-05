hg outgoing
./.bootstrap
./configure --host=$TARGET --enable-maintainer-mode
make
cp gmp.h ~/AndroidStudioProjects/GNUnet/distribution/gmp/lib/include/arm64-v8a/
cp ./.libs/libgmp.so ~/AndroidStudioProjects/GNUnet/distribution/gmp/arm64-v8a/
