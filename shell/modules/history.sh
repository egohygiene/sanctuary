#!/usr/bin/env bash
#
# ============================================
# 📜 EgoHygiene Module — History Management
# ============================================
#
# Redirects shell history and REPL logs to XDG locations.
#
# Guarantees:
# - Idempotent
# - Requires XDG module
# - Cross-shell safe (bash/zsh aware)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_MODULE_HISTORY_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_MODULE_HISTORY_LOADED="true"

# --------------------------------------------
# 🛑 Dependency Check (XDG required)
# --------------------------------------------
if [[ -z "${XDG_STATE_HOME:-}" ]]; then
  return 0
fi

if [[ -n "${XDG_STATE_HOME:-}" ]]; then
  history_state_home="${XDG_STATE_HOME}"
elif [[ -n "${HOME:-}" ]]; then
  history_state_home="${HOME}/.local/state"
else
  return 0
fi

# --------------------------------------------
# 🧠 Shell History
# --------------------------------------------

if shell::is_bash; then
  if ! mkdir -p "${history_state_home}/bash"; then
    printf "[warn] history: unable to create history directory: %s\n" "${history_state_home}/bash" >&2
    return 0
  fi

  export HISTFILE="${history_state_home}/bash/history"
  export HISTSIZE="${EGOHYGIENE_HISTORY_SIZE:-50000}"
  export HISTFILESIZE="${EGOHYGIENE_HISTORY_SIZE:-50000}"
elif shell::is_zsh; then
  if ! mkdir -p "${history_state_home}/zsh"; then
    printf "[warn] history: unable to create history directory: %s\n" "${history_state_home}/zsh" >&2
    return 0
  fi

  export HISTFILE="${history_state_home}/zsh/history"
  export HISTSIZE="${EGOHYGIENE_HISTORY_SIZE:-50000}"
  export SAVEHIST="${EGOHYGIENE_HISTORY_SIZE:-50000}"
fi

# --------------------------------------------
# 🧪 Language REPLs & Runtimes
# --------------------------------------------

mkdir -p "${history_state_home}/history"

export NODE_REPL_HISTORY="${history_state_home}/history/node"
export JULIA_HISTORY="${history_state_home}/history/julia"
export R_HISTFILE="${history_state_home}/history/r"
export OCTAVE_HISTFILE="${history_state_home}/history/octave"
export CALCHISTFILE="${history_state_home}/history/calc"

# --------------------------------------------
# 🗄️ Database & CLI Tools
# --------------------------------------------

export REDISCLI_HISTFILE="${history_state_home}/history/redis"
export SQLITE_HISTORY="${history_state_home}/history/sqlite"
export PSQL_HISTORY="${history_state_home}/history/postgresql"
export PGSQL_HISTORY="${history_state_home}/history/pgsql"
export MYSQL_HISTFILE="${history_state_home}/history/mysql"
export MYSQL_HISTSIZE="${EGOHYGIENE_HISTORY_SIZE:-50000}"

# --------------------------------------------
# 🛠️ System & Debugging Tools
# --------------------------------------------

export LESSHISTFILE="${history_state_home}/history/less"
export LESSHISTSIZE="${EGOHYGIENE_HISTORY_SIZE:-50000}"
export GDBHISTFILE="${history_state_home}/history/gdb"
export UNITS_HISTORY_FILE="${history_state_home}/history/units"
export RLWRAP_HOME="${history_state_home}/history/rlwrap"

unset history_state_home
