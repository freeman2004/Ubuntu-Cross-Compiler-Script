mkdir -vp $PREFIX
mkdir -vp $All_Package
cd $All_Package

export PATH=$PREFIX/bin:$PATH
export CC=arm-linux-gcc
export AR=arm-linux-ar
#### Compile Glibc ####
tar xvf $Location/cross_source/glibc-2.2.3.tar.gz
cd $All_Package/glibc-2.2.3/
tar xvf $Location/cross_source/glibc-linuxthreads-2.2.3.tar.gz

mkdir -pv $All_Package/glibc-2.2.3_build
cd $All_Package/glibc-2.2.3_build

BUILD_CC="gcc" \
CC=$PREFIX/bin/arm-linux-gcc \
AR=$PREFIX/bin/arm-linux-ar \
RANLIB=$PREFIX/bin/arm-linux-ranlib \
../glibc-2.2.3/configure arm-linux \
--prefix=$PREFIX \
--target=arm-linux \
--includedir=$PREFIX/arm-linux/include/linux:$PREFIX/arm-linux/include/asm \
--with-headers=$PREFIX/arm-linux/include \
--disable-profile \
--disable-sanity-checks \
--enable-add-ons=linuxthreads \
-v 2>&1 | tee configure.out

cd $All_Package/glibc-2.2.3_build
sed 's!AR =!AR = '$PREFIX'/bin/arm-linux-ar #!g' -i $All_Package/glibc-2.2.3_build/config.make
sed 's!CFLAGS =!CFLAGS = -O2 -fno-inline -D_FORTIFY_SOURCE=1!g' -i $All_Package/glibc-2.2.3_build/config.make


make 2>&1 | tee make.out
make install
