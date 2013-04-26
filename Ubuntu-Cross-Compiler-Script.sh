#### Parameter ####
Location=`pwd`
All_Package=$Location/all_package/
PREFIX=$All_Package'/cross_compile'

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

clear



echo "** Please select Action **"
echo "** 1. Binutils**"
echo "** 2. linux header **"
echo "** 3. GCC **"
echo "** 4. glibc **"


read Action                  # read character input


case $Action in
    1)
          . $(dirname $0)/sh/Binutils.sh
          ;;
    2)
          . $(dirname $0)/sh/linux_header.sh
          ;;
    3)
          . $(dirname $0)/sh/GCC.sh
          ;;
    4)
          . $(dirname $0)/sh/glibc.sh
          ;;                              
    *)
          clear
          sleep 1;;           # leave the message on the screen for 5 seconds
esac


# http://www.ailis.de/~k/archives/19-arm-cross-compiling-howto.html#toolchain
# http://skyenest.cn/tongji_platform.html
# http://linux.chinaunix.net/techdoc/system/2008/11/08/1044060.shtml

# http://wenku.baidu.com/view/e726b2df5022aaea998f0f9c.html
# http://lamp.linux.gov.cn/Linux/Glibc-GCC-Binutils-Install.html
# http://victoryuembeddedlinux.blogspot.tw/2010/08/arm-cross-compiler-toolchain.html
