mkdir -vp $PREFIX
mkdir -vp $All_Package
cd $All_Package
#### Compile GCC ####

tar xvf $Location/cross_source/gcc-core-2.95.3.tar.gz
#cp -v $All_Package/gcc-2.95.3/gcc/config/arm/t-linux $All_Package/gcc-2.95.3/gcc/config/arm/t-linux.bak
#sed 's/TARGET_LIBGCC2_CFLAGS =/TARGET_LIBGCC2_CFLAGS = -Dinhibit_libc -D__gthr_posix_h/g' -i $All_Package/gcc-2.95.3/gcc/config/arm/t-linux
cp -v $All_Package/gcc-2.95.3/gcc/config/arm/arm.c $All_Package/gcc-2.95.3/gcc/config/arm/arm.c.bak
sed 's!arm_prog_mode = TARGET_APCS_32 ? PROG_MODE_PROG32 : PROG_MODE_PROG26;!if(TARGET_APCS_32) arm_prgmode = PROG_MODE_PROG32; else arm_prgmode= PROG_MODE_PROG26;!g' -i $All_Package/gcc-2.95.3/gcc/config/arm/arm.c
sed 's!O_CREAT!O_CREAT, 0777!g' -i $All_Package/gcc-2.95.3/gcc/collect2.c
mkdir -pv $All_Package/gcc-2.95.3_build

cd $All_Package/gcc-2.95.3_build
../gcc-2.95.3/configure \
--prefix=$PREFIX \
--host=arm-linux
--target=arm-linux \
--disable-shared \
--enable-languages=c
make
make install
