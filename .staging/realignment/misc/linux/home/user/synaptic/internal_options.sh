#!/bin/bash

# References:
# - https://www.linuxquestions.org/questions/debian-26/synaptic-o-set-internal-option-experts-only-714104/
# - source: https://github.com/mvo5/synaptic

# Lists all of synaptics internal options found in the source code.

egrep -ro '_config->\w+\((.*)\)' . | sort | uniq
