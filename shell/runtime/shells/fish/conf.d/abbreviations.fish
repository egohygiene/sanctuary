#
# ============================================
# 📝 EgoHygiene — Fish Abbreviations
# ============================================
#
# Defines shell abbreviations for common workflows.
#
# Abbreviations expand inline as you type, unlike aliases.
# This preserves command transparency and history clarity.
#
# Source material: .staging/fish shell/fish/functions/setup.fish
# Modernized: removed fisher call, used abbr --add idiom.
#
# Loaded automatically by runtime.fish.
#

# --------------------------------------------
# 🛑 Idempotency guard
# --------------------------------------------
if set -q EGOHYGIENE_FISH_ABBR_LOADED
    return 0
end

set -gx EGOHYGIENE_FISH_ABBR_LOADED true

# --------------------------------------------
# 🔀 Git abbreviations
# --------------------------------------------

abbr --add g    git
abbr --add ga   git add
abbr --add gc   git commit
abbr --add gco  git checkout
abbr --add gd   git diff
abbr --add gf   git fetch
abbr --add gm   'git pull --ff-only'
abbr --add gp   git push
abbr --add gr   'git rebase FETCH_HEAD'
abbr --add gs   git status

# --------------------------------------------
# 📂 Directory listing abbreviations
# --------------------------------------------

abbr --add ll   'ls -lhA'
