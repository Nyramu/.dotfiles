MOUNT_POINT="$HOME/Android"
unmount="${args[--unmount]}"

mkdir -p "$MOUNT_POINT"

if [[ $unmount ]]; then
  if ! mountpoint -q "$MOUNT_POINT"; then
    echo "No device mounted at $MOUNT_POINT"
    exit 1
  fi
  fusermount --unmount "$MOUNT_POINT"
  echo "Device successfully unmounted"
else
  if mountpoint -q "$MOUNT_POINT"; then
    echo "A device is already mounted at $MOUNT_POINT"
    exit 1
  fi
  if ! jmtpfs "$MOUNT_POINT"; then
    echo "Failed to mount device - is it connected and unlocked?"
    exit 1
  fi
  echo "Device successfully mounted in $MOUNT_POINT"
fi
