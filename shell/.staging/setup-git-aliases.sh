#!/usr/bin/env sh
git config --global alias.pullall '!git pull && git submodule update --init --recursive'
git config --global alias.pushall '!git push && git submodule foreach --recursive git push'
git config --global alias.reset-hard '!f() { git reset --hard; git clean -df ; }; f'
git config --global alias.sync '!git submodule update --recursive --remote --merge'
