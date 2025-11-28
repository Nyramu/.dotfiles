MOUNT_POINT="$HOME/Android"

unmount=${args[--unmount]}

mkdir -p "$MOUNT_POINT"

if [[ $unmount ]]; then
  fusermount --unmount "$MOUNT_POINT"
  cd
else
  jmtpfs "$MOUNT_POINT"
fi

cd ~/Android
