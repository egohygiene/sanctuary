#!/bin/sh
#
# ============================================
# 🐚 EgoHygiene Runtime — Zsh Layer
# ============================================
#

if [ -n "${EGOHYGIENE_RUNTIME_ZSH_LOADED:-}" ]; then
  return 0
fi

export EGOHYGIENE_RUNTIME_ZSH_LOADED="true"
