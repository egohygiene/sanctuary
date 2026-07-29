#!/usr/bin/env zsh
#
# ============================================
# 🐚 EgoHygiene Runtime — Zsh Layer
# ============================================
#

if [ -n "${EGOHYGIENE_RUNTIME_ZSH_LOADED:-}" ]; then
  return 0
fi

export EGOHYGIENE_RUNTIME_ZSH_LOADED="true"

if [[ -o interactive ]]; then
  setopt APPEND_HISTORY
  setopt EXTENDED_HISTORY
  setopt HIST_EXPIRE_DUPS_FIRST
  setopt HIST_IGNORE_DUPS
  setopt HIST_IGNORE_SPACE
  setopt INTERACTIVE_COMMENTS
  setopt SHARE_HISTORY
fi
