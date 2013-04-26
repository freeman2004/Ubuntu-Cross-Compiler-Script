mkdir -vp $PREFIX
mkdir -vp $All_Package
cd $All_Package
#### Copy linux header ####
tar xvf $Location/cross_source/linux-2.4.17.tar.gz
mv $All_Package/linux $All_Package/linux-2.4.17
cd $All_Package/linux-2.4.17
zcat $Location/cross_source/patch-2.4.17-rmk4.gz | patch -p1

sed 's!ARCH :=!ARCH := arm#!g' -i $All_Package/linux-2.4.17/Makefile
sed '/-O2 -fomit-frame-pointer/,/CROSS_COMPILE/{/-O2 -fomit-frame-pointer/!d}' -i ./Makefile
sed '22iCROSS_COMPILE   = arm-linux-\n' -i ./Makefile
make clean

cd $All_Package/linux-2.4.17
make ARCH=arm menuconfig

cd $All_Package/linux-2.4.17/include/asm-arm/
sleep 0.5
rm -f arch proc
sleep 0.5
ln -s arch-clps711x arch
sleep 0.5
ln -s proc-armv proc

mkdir -pv $PREFIX/arm-linux/include # /arm-linux/ toolchain directory already have
cp -dR $All_Package/linux-2.4.17/include/asm-arm $PREFIX/arm-linux/include/asm
cp -dR $All_Package/linux-2.4.17/include/linux $PREFIX/arm-linux/include/linux
cd $PREFIX/arm-linux
ln -s include sys-linux
