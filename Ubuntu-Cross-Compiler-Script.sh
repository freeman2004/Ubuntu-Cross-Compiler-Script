#### Parameter ####
Location=`pwd`
PREFIX=$Location'/4.3.2'

#### Download Code ####
#mkdir $Location/cross_source
#cd $Location/cross_source
#wget http://mirrors.usc.edu/pub/gnu/binutils/binutils-2.23.tar.gz

#wget http://ftp.gnu.org/gnu/gcc/gcc-4.3.2/gcc-core-4.3.2.tar.gz
#wget http://ftp.gnu.org/gnu/gcc/gcc-4.3.2/gcc-g++-4.3.2.tar.gz
#wget http://www.mpfr.org/mpfr-2.3.2/mpfr-2.3.2.tar.gz
#wget http://ftp.gnu.org/gnu/gmp/gmp-4.2.4.tar.gz
#wget https://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.28.tar.gz

#wget http://ftp.gnu.org/gnu/glibc/glibc-2.13.tar.gz
#wget http://ftp.gnu.org/gnu/glibc/glibc-ports-2.13.tar.gz

#wget http://ftp.gnu.org/gnu/glibc/glibc-2.11.tar.gz
#wget http://ftp.gnu.org/gnu/glibc/glibc-ports-2.11.tar.gz

#wget http://ftp.gnu.org/gnu/glibc/glibc-2.8.tar.gz
#wget http://ftp.gnu.org/gnu/glibc/glibc-ports-2.8.tar.gz

#wget http://ftp.gnu.org/gnu/libc/glibc-ports-2.7.tar.gz # include arm library patch
#wget http://ftp.gnu.org/gnu/libc/glibc-2.7.tar.gz
#cd ..


mkdir -vp $PREFIX

#### Compile Binutils ####
tar xvf $Location/cross_source/binutils-2.11.2.tar.gz
mkdir -pv binutils-2.11.2_build
cd binutils-2.11.2_build
../binutils-2.11.2/configure --target=arm-linux --prefix=$PREFIX
make && make install


#### Copy linux header ####
tar xvf $Location/cross_source/linux-2.4.17.tar.gz
mv $Location/linux $Location/linux-2.4.17
cd $Location/linux-2.4.17
zcat $Location/cross_source/patch-2.4.17-rmk4.gz | patch -p1

sed 's!ARCH :=!ARCH := arm#!g' -i $Location/linux-2.4.17/Makefile
sed '/-O2 -fomit-frame-pointer/,/CROSS_COMPILE/{/-O2 -fomit-frame-pointer/!d}' -i ./Makefile
sed '22iCROSS_COMPILE   = arm-linux-\n' -i ./Makefile
make clean

cd $Location/linux-2.4.17
make ARCH=arm menuconfig

cd $Location/linux-2.4.17/include/asm-arm/
sleep 0.5
rm -f arch proc
sleep 0.5
ln -s arch-clps711x arch
sleep 0.5
ln -s proc-armv proc

mkdir -pv $Location/4.3.2/arm-linux/include # /4.3.2/arm-linux/ toolchain directory already have
cp -dR $Location/linux-2.4.17/include/asm-arm $Location/4.3.2/arm-linux/include/asm
cp -dR $Location/linux-2.4.17/include/linux $Location/4.3.2/arm-linux/include/linux
cd $Location/4.3.2/arm-linux
ln -s include sys-linux

#### Compile GCC ####
export PATH=$PREFIX/bin:$PATH

tar xvf $Location/cross_source/gcc-core-2.95.3.tar.gz
cp $Location/gcc-2.95.3/gcc/config/arm/t-linux{,.bak}
sed 's/TARGET_LIBGCC2_CFLAGS =/TARGET_LIBGCC2_CFLAGS = -Dinhibit_libc -D__gthr_posix_h/g' -i $Location/gcc-2.95.3/gcc/config/arm/t-linux
cp $Location/gcc-2.95.3/gcc/config/arm/arm.c{,.bak}
sed 's!arm_prog_mode = TARGET_APCS_32 ? PROG_MODE_PROG32 : PROG_MODE_PROG26;!if(TARGET_APCS_32) arm_prgmode = PROG_MODE_PROG32; else arm_prgmode= PROG_MODE_PROG26;!g' -i $Location/gcc-2.95.3/gcc/config/arm/arm.c
sed 's!O_CREAT!O_CREAT, 0777!g' -i $Location/gcc-2.95.3/gcc/collect2.c
mkdir -pv $Location/gcc-2.95.3_build

cd $Location/gcc-2.95.3_build
../gcc-2.95.3/configure \
--target=arm-linux \
--host=arm-linux \
--prefix=$PREFIX \
--disable-shared \
--enable-languages=c
make
make install




export PATH=$PREFIX/bin:$PATH
export CC=arm-linux-gcc
export AR=arm-linux-ar
#### Compile Glibc ####
tar xvf $Location/cross_source/glibc-2.2.3.tar.gz
cd $Location/glibc-2.2.3/
tar xvf $Location/cross_source/glibc-linuxthreads-2.2.3.tar.gz

mkdir -pv $Location/glibc-2.2.3_build
cd $Location/glibc-2.2.3_build

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


cd $Location/glibc-2.2.3_build
sed 's!AR =!AR = '$PREFIX'/bin/arm-linux-ar #!g' -i $Location/glibc-2.2.3_build/config.make
sed 's!CFLAGS =!CFLAGS = -O2 -fno-inline -D_FORTIFY_SOURCE=1!g' -i $Location/glibc-2.2.3_build/config.make


make | tee make.out
make install



# http://www.ailis.de/~k/archives/19-arm-cross-compiling-howto.html#toolchain
# http://skyenest.cn/tongji_platform.html
# http://linux.chinaunix.net/techdoc/system/2008/11/08/1044060.shtml

# http://wenku.baidu.com/view/e726b2df5022aaea998f0f9c.html
# http://lamp.linux.gov.cn/Linux/Glibc-GCC-Binutils-Install.html
# http://victoryuembeddedlinux.blogspot.tw/2010/08/arm-cross-compiler-toolchain.html
