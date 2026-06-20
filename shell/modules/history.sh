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
if [[ -z "${XDG_CACHE_HOME:-}" ]]; then
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
    printf "[warn] history.sh: unable to create history directory: %s\n" "${history_state_home}/bash" >&2
    return 0
  fi

  export HISTFILE="${history_state_home}/bash/history"
  export HISTSIZE="10000"
elif shell::is_zsh; then
  if ! mkdir -p "${history_state_home}/zsh"; then
    printf "[warn] history.sh: unable to create history directory: %s\n" "${history_state_home}/zsh" >&2
    return 0
  fi

  export HISTFILE="${history_state_home}/zsh/history"
  export HISTSIZE="10000"
  export SAVEHIST="10000"
fi

# --------------------------------------------
# 🧪 Language REPLs & Runtimes
# --------------------------------------------

export NODE_REPL_HISTORY="${XDG_CACHE_HOME}/node_repl_history"
export JULIA_HISTORY="${XDG_CACHE_HOME}/julia_history"
export R_HISTFILE="${XDG_CACHE_HOME}/R_history"
export OCTAVE_HISTFILE="${XDG_CACHE_HOME}/octave-hsts"
export CALCHISTFILE="${XDG_CACHE_HOME}/calc_history"

# --------------------------------------------
# 🗄️ Database & CLI Tools
# --------------------------------------------

export REDISCLI_HISTFILE="${XDG_CACHE_HOME}/rediscli_history"
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"
export PSQL_HISTORY="${XDG_CACHE_HOME}/psql_history"
export PGSQL_HISTORY="${XDG_CACHE_HOME}/pgsql_history"
export MYSQL_HISTFILE="${XDG_CACHE_HOME}/mysql_history"
export MYSQL_HISTSIZE="10000"

# --------------------------------------------
# 🛠️ System & Debugging Tools
# --------------------------------------------

export LESSHISTFILE="${XDG_CACHE_HOME}/less_history"
export LESSHISTSIZE="10000"
export GDBHISTFILE="${XDG_CACHE_HOME}/gdb_history"
export UNITS_HISTORY_FILE="${XDG_CACHE_HOME}/units_history"
export RLWRAP_HOME="${XDG_CACHE_HOME}/rlwrap"

unset history_state_home
