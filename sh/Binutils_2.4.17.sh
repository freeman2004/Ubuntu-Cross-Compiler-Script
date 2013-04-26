mkdir -vp $PREFIX
mkdir -vp $All_Package
cd $All_Package
#### Compile Binutils ####
tar xvf $Location/cross_source/binutils-2.11.2.tar.gz
mkdir -pv $All_Package/binutils-2.11.2_build
cd $All_Package/binutils-2.11.2_build
../binutils-2.11.2/configure \
--target=arm-linux \
--prefix=$PREFIX
make
make install
