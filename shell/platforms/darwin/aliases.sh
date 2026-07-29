#!/usr/bin/env bash
# shellcheck shell=bash

case $- in
  *i*) ;;
  *) return 0 ;;
esac

alias show-hidden-files="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide-hidden-files="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

flushdns() {
  sudo dscacheutil -flushcache &&
    sudo killall -HUP mDNSResponder &&
    printf "DNS cache flushed.\n"
}

lockscreen() {
  open -a "ScreenSaverEngine"
}
