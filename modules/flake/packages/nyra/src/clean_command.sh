delete_old=${args=[--delete-old]}

TIMESPAN="7d"

if [[ $delete_old ]]; then
  nh clean all --keep-one
else
  nh clean all --keep-one --keep-since ${TIMESPAN}
fi
