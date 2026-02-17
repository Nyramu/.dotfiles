MOUNT_POINT="$HOME/Android"
unmount="${args=[--unmount]}"

mkdir -p "$MOUNT_POINT"

if [[ $unmount ]]; then
  fusermount --unmount "$MOUNT_POINT" 2>/dev/null
  echo "Device successfully unmounted"
else
  jmtpfs "$MOUNT_POINT"
  echo "Device successfully mounted in $MOUNT_POINT"
  echo "To access: cd $MOUNT_POINT"
fi
