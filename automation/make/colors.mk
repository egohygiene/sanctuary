##### Terminal Colors and Formatting. #####
### References:
###	[1]: https://misc.flogisoft.com/bash/tip_colors_and_formatting
### [2]: https://www2.ccs.neu.edu/research/gpc/VonaUtils/vona/terminal/vtansi.htm
#####

# Prevents multiple inclusions of the library. #
ifndef __included_colors

__included_colors := true

## Formatting ##
BOLD := \033[1m
DIM := \033[2m
UNDERLINED := \033[4m
BLINK := \033[5m
REVERSE := \033[7m
HIDDEN := \033[8m

## Reset ##
RESET_COLOR := \033[0m
RESET_BOLD := \033[22m
RESET_DIM := \033[22m
RESET_UNDERLINED := \033[24m
RESET_BLINK := \033[25m
RESET_REVERSE := \033[27m
RESET_HIDDEN := \033[28m

## Text Colors ##
BANNER_COLOR := \033[38;5;74m
OK_COLOR := \033[32;01m
WARNING_COLOR := \033[33;01m
ERROR_COLOR := \033[31;01m
DEFAULT_COLOR := \033[39m
BLACK := \033[30m
RED := \033[31m
GREEN := \033[32m
YELLOW := \033[33m
BLUE := \033[34m
MAGENTA := \033[35m
CYAN := \033[36m
LIGHT_GRAY := \033[37m
DARK_GRAY := \033[90m
LIGHT_RED := \033[91m
LIGHT_GREEN := \033[92m
LIGHT_YELLOW := \033[93m
LIGHT_BLUE := \033[94m
LIGHT_MAGENTA := \033[95m
LIGHT_CYAN := \033[96m
WHITE := \033[97m

## Background Colors ##
BG_DEFAULT := \033[49m
BG_BLACK := \033[40m
BG_RED := \033[41m
BG_GREEN := \033[42m
BG_YELLOW := \033[43m
BG_BLUE := \033[44m
BG_MAGENTA := \033[45m
BG_CYAN := \033[46m
BG_LIGHT_GRAY := \033[47m
BG_DARK_GRAY := \033[100m
BG_LIGHT_RED := \033[101m
BG_LIGHT_GREEN := \033[102m
BG_LIGHT_YELLOW := \033[103m
BG_LIGHT_BLUE := \033[104m
BG_LIGHT_MAGENTA := \033[105m
BG_LIGHT_CYAN := \033[106m
BG_WHITE := \033[107m

## tput Colors ##
tRED := $(shell TERM=$${TERM:-dumb} tput setaf 1 2>/dev/null || printf '')
tGREEN := $(shell TERM=$${TERM:-dumb} tput setaf 2 2>/dev/null || printf '')
tYELLOW := $(shell TERM=$${TERM:-dumb} tput setaf 3 2>/dev/null || printf '')
tBLUE := $(shell TERM=$${TERM:-dumb} tput setaf 4 2>/dev/null || printf '')
tMAGENTA := $(shell TERM=$${TERM:-dumb} tput setaf 5 2>/dev/null || printf '')
tCYAN := $(shell TERM=$${TERM:-dumb} tput setaf 6 2>/dev/null || printf '')
tWHITE := $(shell TERM=$${TERM:-dumb} tput setaf 7 2>/dev/null || printf '')
tBOLD := $(shell TERM=$${TERM:-dumb} tput bold 2>/dev/null || printf '')
tRESET := $(shell TERM=$${TERM:-dumb} tput sgr0 2>/dev/null || printf '')

## Functions ##
define change_color
echo "$(1)"
endef

define reset_color
echo "$(RESET_COLOR)"
endef

endif
