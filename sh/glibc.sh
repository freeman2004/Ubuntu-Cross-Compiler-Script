echo "** Please select glibc version **"
echo "** 1. glibc-2.2.3 **"


read glibc_header                  # read character input


case $glibc_header in
    1)
          . $(dirname $0)/sh/glibc-2.2.3.sh
          ;;
    *)
          clear
          sleep 1;;           # leave the message on the screen for 5 seconds
esac
