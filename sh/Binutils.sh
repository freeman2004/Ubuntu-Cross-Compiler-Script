echo "** Please select binutils version **"
echo "** 1. Binutils-2.11.2 **"

read Binutils_version                  # read character input


case $Binutils_version in
    1)
          . $(dirname $0)/sh/Binutils_2.4.17.sh
          ;;
    *)
          clear
          sleep 1;;           # leave the message on the screen for 5 seconds
esac
