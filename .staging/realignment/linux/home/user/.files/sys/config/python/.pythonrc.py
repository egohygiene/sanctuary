import sys
def register_readline_completion():
    # rlcompleter must be loaded for Python-specific completion
    try: import readline, rlcompleter
    except ImportError: return
    # Enable tab-completion
    readline_doc = getattr(readline, '__doc__', '')
    if readline_doc is not None and 'libedit' in readline_doc:
        readline.parse_and_bind('bind ^I rl_complete')
    else:
        readline.parse_and_bind('tab: complete')
sys.__interactivehook__ = register_readline_completion






#!/usr/bin/env python

import os
import sys
import atexit
import rlcompleter
import readline


HISTORY_FILE_PATH = os.path.expanduser('~/.python_history')


class IndentableCompleter(rlcompleter.Completer):
    def complete(self, text, state):
        if text == '' or text.isspace():
            return ['    ', None][state]
        else:
            return super().complete(text, state)


def save_history(history_file_path=HISTORY_FILE_PATH):
    import sys
    if sys.version_info.major > 2:
        import readline
        readline.write_history_file(history_file_path)


def load_history(history_file_path=HISTORY_FILE_PATH):
    if sys.version_info.major > 2 and os.path.exists(HISTORY_FILE_PATH):
        readline.read_history_file(HISTORY_FILE_PATH)


load_history()

readline.parse_and_bind('tab: complete')
readline.set_completer(IndentableCompleter().complete)

atexit.register(save_history)
del os, atexit, readline, rlcompleter, sys, save_history, load_history, HISTORY_FILE_PATH

