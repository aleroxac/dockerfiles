#!/usr/bin/env bash

dotenvfile=${1}
while read -r line; do
  key=$(echo "${line}" | cut -d= -f1)
  value=$(eval echo "$(echo "${line}" | cut -d= -f2-)")
  echo "${key}"="'${value}'"
done < "${dotenvfile}" | grep -E "^[A-Z]"
