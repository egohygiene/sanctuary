#!/usr/bin/env python
"""
Universal Python RC file
- Tab completion (with indent support)
- Persistent history (XDG-aware)
- Pretty-printing and rich tracebacks
- Safe fallbacks for missing modules
"""

import atexit
import os
import sys
import warnings

# -----------------------------------------------------------------------------
# XDG-compliant history path
# -----------------------------------------------------------------------------
XDG_STATE_HOME = os.environ.get("XDG_STATE_HOME", os.path.expanduser("~/.local/state"))
HIST_DIR = os.path.join(XDG_STATE_HOME, "python")
HIST_FILE = os.path.join(HIST_DIR, "history")

os.makedirs(HIST_DIR, exist_ok=True)

# -----------------------------------------------------------------------------
# Tab completion with smart indent
# -----------------------------------------------------------------------------
try:
    import readline, rlcompleter

    class IndentableCompleter(rlcompleter.Completer):
        def complete(self, text, state):
            if text.strip() == "":
                return ["    ", None][state]
            return super().complete(text, state)

    readline.set_completer(IndentableCompleter().complete)
    if "libedit" in (getattr(readline, "__doc__", "") or "").lower():
        readline.parse_and_bind("bind ^I rl_complete")
    else:
        readline.parse_and_bind("tab: complete")

    # History load/save
    if os.path.exists(HIST_FILE):
        try:
            readline.read_history_file(HIST_FILE)
        except Exception:
            pass

    def save_history(path=HIST_FILE):
        try:
            readline.write_history_file(path)
        except Exception:
            pass

    atexit.register(save_history)
except ImportError:
    pass

# -----------------------------------------------------------------------------
# Pretty tracebacks
# -----------------------------------------------------------------------------
try:
    import rich.traceback
    rich.traceback.install(show_locals=True, suppress=[os])
except ImportError:
    try:
        import better_exceptions
    except ImportError:
        # fallback: enable builtin tracebacks
        sys.excepthook = sys.__excepthook__

# -----------------------------------------------------------------------------
# Preload handy modules
# -----------------------------------------------------------------------------
try:
    import pprint
    __builtins__["pp"] = pprint.pprint
except Exception:
    pass

try:
    import datetime as dt
    __builtins__["dt"] = dt
except Exception:
    pass

try:
    from pathlib import Path
    __builtins__["Path"] = Path
except Exception:
    pass

# -----------------------------------------------------------------------------
# Default warnings
# -----------------------------------------------------------------------------
warnings.simplefilter("default")

# -----------------------------------------------------------------------------
# Clean up namespace
# -----------------------------------------------------------------------------
del os, atexit, warnings, HIST_DIR, HIST_FILE, XDG_STATE_HOME
