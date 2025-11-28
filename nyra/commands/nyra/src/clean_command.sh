delete_old=${args[--delete-old]}

TIMESPAN="7d"

if [[ $delete_old ]]; then
  nh clean all --no-gcroots
else
  nh clean all --no-gcroots --keep-since ${TIMESPAN}
fi
