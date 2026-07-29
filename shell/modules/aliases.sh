#!/usr/bin/env bash
# shellcheck shell=bash
#
# Portable, low-surprise interactive aliases and helpers for Bash and Zsh.

if [[ -n "${EGOHYGIENE_MODULE_ALIASES_LOADED:-}" ]]; then
  return 0
fi
export EGOHYGIENE_MODULE_ALIASES_LOADED="true"

case $- in
  *i*) ;;
  *) return 0 ;;
esac

alias c="clear"
alias cls="clear"
alias environment="printenv | LC_ALL=C sort"
alias path="printf \"%s\\n\" \"\$PATH\" | tr \":\" \"\\n\""
alias now="date +%Y-%m-%dT%H:%M:%S"
alias unow="date -u +%Y-%m-%dT%H:%M:%S"
alias nowdate="date +%Y-%m-%d"
alias unowdate="date -u +%Y-%m-%d"
alias nowtime="date +%H:%M:%S"
alias unowtime="date -u +%H:%M:%S"
alias timestamp="date -u +%s"
alias week="date +%G-W%V"
alias weekday="date +%u"
alias month="date +%B"
alias year="date +%Y"
alias clone="git clone"
alias ascii="man ascii"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

if guard::has_command "eza"; then
  alias ls="eza --group-directories-first"
  alias ll="eza --all --long --group-directories-first --git"
  alias lt="eza --tree --icons=auto --git"
  alias lss="eza --long --header --total-size --icons=auto --sort=size"
else
  alias ll="ls -al"
fi

if guard::has_command "dust"; then
  alias dud="dust --depth 1"
fi

if ! guard::has_command "md5sum" && guard::has_command "md5"; then
  alias md5sum="md5"
fi

if ! guard::has_command "sha1sum" && guard::has_command "shasum"; then
  alias sha1sum="shasum --algorithm 1"
fi

if guard::has_command "python3"; then
  alias pretty-json="python3 -m json.tool --sort-keys --no-ensure-ascii"
fi

if guard::has_command "gallery-dl"; then
  alias gallery-dl='gallery-dl --config "${XDG_CONFIG_HOME}/gallery-dl/config.json"'
fi

if guard::has_command "feh"; then
  alias photos="feh --auto-zoom --image-bg black --randomize --recursive --scale-down ."
fi

if guard::has_command "mount" && guard::has_command "column"; then
  alias mounts="mount | column -t"
fi

egohygiene::reload() {
  exec "${SHELL}" --login
}

egohygiene::mkcd() {
  if (($# != 1)); then
    printf "Usage: mkcd DIRECTORY\n" >&2
    return 64
  fi
  mkdir -p -- "$1" || return
  builtin cd -- "$1" || return
}

egohygiene::man() {
  LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    command man "$@"
}

alias reload="egohygiene::reload"
alias mkcd="egohygiene::mkcd"
alias man="egohygiene::man"

# These aliases add prompts but still change familiar command behavior, so they
# require explicit consent.
if [[ "${EGOHYGIENE_ENABLE_SAFETY_ALIASES:-0}" == "1" ]]; then
  alias cp="cp -i"
  alias mv="mv -i"
  alias rm="rm -i"
fi
