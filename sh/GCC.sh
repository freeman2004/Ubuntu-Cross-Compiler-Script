
echo "** Please select GCC version **"
echo "** 1. GCC 2.95.3 **"

read GCC_header                  # read character input


case $GCC_header in
    1)
          . $(dirname $0)/sh/GCC_2.95.3.sh
          ;;
    *)
          clear
          sleep 1;;           # leave the message on the screen for 5 seconds
esac

