#!/usr/bin/make -f
# -*- mode: Makefile; -*-
##### Makefile Targets #####
MAKE_LIBRARY_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
include $(MAKE_LIBRARY_DIR)/project.mk

.ONESHELL:

# Define the default target:
.DEFAULT_GOAL := all

# Remove targets if its recipe fails.
# [1]: https://www.gnu.org/software/make/manual/html_node/Special-Targets.html
.DELETE_ON_ERROR:

# Remove all the default suffixes, preferring to define all rules explicitly.
# [1]: https://www.gnu.org/software/make/manual/html_node/Suffix-Rules.html#Suffix-Rules
.SUFFIXES:

define activate
. $(HOME)/.nvm/nvm.sh
endef

NVM_DIR = $(HOME)/.nvm

nvm:
	. ${NVM_DIR}/nvm.sh && nvm use && $(CMD)
nvm-test:
	make nvm CMD="node --version"

.PHONY: check-nvm
check-nvm: # will error with link to install NVM if it's not installed
	@bash -l -c 'type -t nvm > /dev/null || { echo -e "\x1b[31mYou need to install NVM:\x1b[0m https://github.com/nvm-sh/nvm#installation-and-update"; exit 1; }'


all:	## Default target. Prints project-related information.
	@$(call banner,Running Makefile for $(NAME))
	@$(call print_pair,GNU Make Version,$(MAKE_VERSION))
	@$(call print_pair,Operating System,$(OPERATING_SYSTEM))
	@$(call print_pair,Main Shell,$(SHELL))
	@$(call print_pair,Target Shell,$(CURRENT_SHELL))
	@$(call print_pair,Terminal,$(TERM))
	@$(call print_pair,Project,$(NAME))
	@$(call print_pair,Make Command,$(MAKE) $(MFLAGS))
	@$(call print_pair,Host System,$(MAKE_HOST))
	@$(call print_pair,Includes,$(.INCLUDE_DIRS))
	@$(call print_pair,Temp Directory,$(TMPDIR))
	@$(call print_pair,PATH Environment,$(PATH))
	@$(call print_pair,User,$(USER_NAME))
	@$(call print_pair,User Home,$(HOME))
	@$(call print_pair,Default Goal,'$(.DEFAULT_GOAL)')

.PHONY: help
help:	## Show the help.
	@$(call banner,"Makefile for $(NAME)")
	@echo "  Usage: $(MAGENTA)make <target>$(RESET_COLOR)"
	@echo "         $(MAGENTA)make <target> $(CYAN)<VAR>=<value>$(RESET_COLOR)"
	@echo ""
	@echo "  Targets:"
	@$(call help)

.PHONY: proxy
proxy:	## Proxy Environment.
	@$(call banner,Proxy Environment)
	@$(call print_pair,HTTP Proxy,$(HTTP_PROXY))
	@$(call print_pair,HTTPS Proxy,$(HTTPS_PROXY))

.PHONY: variables
variables:	## Prints all the Makefile variables.
	@$(call banner,Makefile Variables)
	@$(call print_sorted,$(.VARIABLES))

.PHONY: targets
targets:	## Prints all the Makefile targets.
	@$(call banner,Makefile Targets)
	@$(call print_sorted,$(ALL_TARGETS))

.PHONY: features
features:	## Prints all the Makefile features.
	@$(call banner,Makefile Features)
	@$(call print_sorted,$(.FEATURES))

.PHONY: virtualenv
virtualenv:		## Install Python virtual environment.
	@$(call banner,Installing Python virtual environment...)
	@$(call virtualenv)

.PHONY: python-env
python-env:  	## Prints information about the python runtime environment.
	@$(call banner,Python virtual environment...)
	@$(call python_env)

.PHONY: clean
clean:
	@$(call banner,Cleaning)
	rm -rf ./$(build_dir)

.PHONY: poetry-sort
poetry-sort:  	## Prints information about the python runtime environment.
	@$(call banner,Sorting python dependencies...)
	@$(call poetry_sort)

.PHONY: hadolint
hadolint:	## Runs hadolint over project.
	@$(call banner,Running hadolint...)
	#$(call hadolint)

.PHONY: codespell
codespell:		## Runs codespell over project.
	@$(call banner,Running codespell...)
	@$(call codespell)

.PHONY: pylic
pylic:	## Runs pylic over project.
	@$(call banner,Running pylic...)
	@$(call pylic)