##### Makefile Common Variables and Functions. #####
### References:
###	[1]: https://www.gnu.org/software/make/manual/make.html
### [2]: https://www.oreilly.com/library/view/managing-projects-with/0596006101/ch07.html
### [3]: https://github.com/gvalkov/gnu-make-toolkit/blob/master/toolkit.mk
### [4]: https://github.com/seek-oss/kpt-functions/blob/master/Makefile
### [5]: https://github.com/stdlib-js/utils-argument-function/blob/main/Makefile
### [6]: https://en.wikipedia.org/wiki/Uname#Examples
### [7]: http://stackoverflow.com/a/27776822/2225624
### [8]: https://github.com/jgrahamc/gmsl
### [9]:
#####
include $(CURDIR)/scripts/os.mk
include $(CURDIR)/scripts/gmsl.mk
include $(CURDIR)/scripts/colors.mk

### Verify that the GNU Make executable version is valid. ###
MIN_MAKE_VERSION := 4.0
MIN_MAKE_ERROR := Makefile requires $(MIN_MAKE_VERSION) or greater. Current version is "$(MAKE_VERSION)".

ifneq "$(MIN_MAKE_VERSION)" "$(firstword $(sort $(MIN_MAKE_VERSION) $(MAKE_VERSION)))"
    $(error $(MIN_MAKE_ERROR))
endif

### Common Variables ###
USER_NAME:=$(shell whoami)
comma := ,
empty :=
space := $(empty) $(empty)
tab :=	#
null := \0
colon := $(empty):$(empty)
underscore := $(empty)_$(empty)
open := (
close := )
OK_TAG := OK
WARN_TAG := WARN
ERROR_TAG := ERROR
DEFAULT_TRUNCATE := 100

### Common Functions ###

## NAME: newline
## DESC: Function to return the newline character.
define \n


endef

## Function for printing a pretty banner.
define banner
echo "\n$(BANNER_COLOR)===== $1 =====$(NO_COLOR)"
endef

define map
$(foreach a,$(2),$(call $(1),$(a)))
endef

define space_to_question
$(subst $(space),?,$(1))
endef

define question_to_space
$(subst ?,$(space),$(1))
endef

define wildcard_spaces
$(wildcard $(call space_to_question,$(1)))
endef

define reverse_function
$(2) $(1)
endef

define pathsearch
$(firstword $(wildcard $(addsuffix /$(1),$(subst :, ,$(PATH)))))
endef

define file_exists
$(strip $(call wildcard_spaces,$(1)))
endef

# Function for checking that a variable is defined.
define check_defined
$(strip $(foreach 1,$(1), $(call __check_defined,$(1),$(strip $(value 2)))))
endef

define __check_defined
$(if $(value $(1)),,$(error Undefined $(1)$(if $(2), ($2))$(if $(value @),required by target `$@`)))
endef

define executable
$(if $(call check_executable,$(1)),$(shell $(WHICH) $(1)),$(error Undefined $(1) $(if $(2), ($(2))) $(if $(value @),required by target `$@`)))
endef

define newline_to_comma
$(subst $(newline),$(comma),$(1))
endef

# Defining dir and notdir functions that handle whitespaces. Based upon: https://stackoverflow.com/a/1189900.
# Escape provided string path by replacing spaces with the null character.
define escape_path
$(subst $(space),$(null),$1)
endef

# Unescape provided string path by replacing null characters with spaces.
define unescape_path
$(subst $(null),$(space),$1)
endef

# Replacement function for 'dir' function that handles whitespaces.
define dirx
$(call unescape_path,$(dir $(call escape_path,$1)))
endef

# Replacement function for 'notdir' function that handles whitespaces.
define notdirx
$(call unescape_path,$(notdir $(call escape_path,$1)))
endef

# Makefile logger. https://github.com/Noah-Huppert/make-log
define log
$(if $(findstring ok, $(1)), @printf "$(OK_COLOR)[$(OK_TAG)] $(2)$(NO_COLOR)\n")
$(if $(findstring warn, $(1)), @printf "$(WARN_COLOR)[$(WARN_TAG)] $(2)$(NO_COLOR)\n")
$(if $(findstring error, $(1)), @printf "$(ERROR_COLOR)[$(ERROR_TAG)] $(2)$(NO_COLOR)\n")
endef

# https://stackoverflow.com/a/18258352
define rwildcard
$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$(d)))
endef

define truncate
$(call substr,$(1),1,$(if $(strip $(2)),$(2),$(DEFAULT_TRUNCATE)))
endef

define print
echo $(call truncate,$(1),$(2))
endef

define print_pair
echo "$(BOLD)$(MAGENTA)$(1)$(RESET_BOLD): $(CYAN)$(shell $(call print,$(2)))$(RESET_COLOR)"
endef

define print_list
$(foreach item,$(1),echo "$(MAGENTA)$(item)$(RESET_COLOR)";)
endef

define print_sorted
$(call print_list,$(sort $(1)))
endef
