#!/usr/bin/env bash
# shellcheck shell=bash

if [[ -n "${EGOHYGIENE_LIB_INSTALL_PACKAGE_MANAGER_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_INSTALL_PACKAGE_MANAGER_LOADED="true"

install::package_manager::detect() {
  if guard::has_command brew; then
    printf "brew\n"
  elif guard::has_command apt-get; then
    printf "apt\n"
  elif guard::has_command dnf; then
    printf "dnf\n"
  elif guard::has_command yum; then
    printf "yum\n"
  elif guard::has_command pacman; then
    printf "pacman\n"
  elif guard::has_command apk; then
    printf "apk\n"
  elif guard::has_command winget; then
    printf "winget\n"
  elif guard::has_command scoop; then
    printf "scoop\n"
  elif guard::has_command choco; then
    printf "choco\n"
  else
    printf "unknown\n"
  fi
}
