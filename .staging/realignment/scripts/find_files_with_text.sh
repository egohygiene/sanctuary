#!/usr/bin/env bash

TEXT="${1}"

# Find files containing the provided text.
grep -lir "${TEXT}"
