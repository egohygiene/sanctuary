#!/usr/bin/env bash


run_cmd() {
  "${1}" ${2}
}

is_command() {
  for item in "$@"; do
    if ! command -v "${item}" > /dev/null 2>&1; then
      return 1
    fi
  done
  return 0
}

if is_command echo npm; then
  echo "HELLO"
else
  echo "NOOO"
fi

