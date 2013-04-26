echo "** Please select linux header version **"
echo "** 1. linux header 2.4.17 **"

read linux_header                  # read character input


case $linux_header in
    1)
          . $(dirname $0)/sh/linux_header_2.4.17.sh
          ;;
    *)
          clear
          sleep 1;;           # leave the message on the screen for 5 seconds
esac
