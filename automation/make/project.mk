##### Makefile Project Specific Variables and Functions #####
# Resolve from this file as a fallback when the module is included standalone.
MAKE_LIBRARY_DIR ?= $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
include $(MAKE_LIBRARY_DIR)/common.mk

### Project Variables. ###
NAME := cryptocurrency-trading-suite
PROJECT_MAKEFILE := $(abspath $(firstword $(MAKEFILE_LIST)))

## Directories. ##
WORKING_DIR := $(CURDIR)
PROJECT_DIR := $(call dirx,$(PROJECT_MAKEFILE))
CACHE_DIR := $(PROJECT_DIR).cache
POETRY_CACHE := $(CACHE_DIR)/pypoetry
STYLELINT_CACHE := $(CACHE_DIR)/stylelint
VENV := $(PROJECT_DIR).venv
VENV_PREFIX := $(VENV)/bin
TOOLS_DIR := $(PROJECT_DIR)tools
API_ROOT := $(PROJECT_DIR)api
DASHBOARD_ROOT := $(PROJECT_DIR)dashboard
REPORTS_DIR := $(PROJECT_DIR)reports

## Files. ##
VENV_ACTIVATE := $(VENV_PREFIX)/activate
ENV_FILE := $(PROJECT_DIR).env
DOCKER_COMPOSE := $(PROJECT_DIR)docker-compose.yml
FILE_FINDER := $(TOOLS_DIR)/file_finder.py
CODE_OF_CONDUCT := $(PROJECT_DIR)CODE_OF_CONDUCT.md
CONTRIBUTING := $(PROJECT_DIR)CONTRIBUTING.md
DOCKERFILE := $(PROJECT_DIR)Dockerfile
POETRY_LOCK := $(PROJECT_DIR)poetry.lock
POETRY_TOML := $(PROJECT_DIR)poetry.toml
PYPROJECT_TOML := $(PROJECT_DIR)pyproject.toml

# Configuration Files. #
BANDIT_CONFIG := $(PROJECT_DIR).bandit
CODESPELL_CONFIG := $(PROJECT_DIR).codespellrc
COMMITLINT_CONFIG := $(PROJECT_DIR).commitlintrc.yaml
DARGLINT_CONFIG := $(PROJECT_DIR).darglint
FLAKE8_CONFIG := $(PROJECT_DIR).flake8
HADOLINT_CONFIG := $(PROJECT_DIR).hadolint.yml
MARKDOWNLINT_CONFIG := $(PROJECT_DIR).markdownlint.yaml
NPM_CONFIG := $(PROJECT_DIR).npmrc
NVM_CONFIG := $(PROJECT_DIR).nvmrc
PYLINT_CONFIG := $(PROJECT_DIR).pylintrc
SHELLCHECK_CONFIG := $(PROJECT_DIR).shellcheckrc
SPELLING := $(PROJECT_DIR).spelling
STYLELINT_CONFIG := $(PROJECT_DIR).stylelint.yml
MKDOCS_CONFIG := $(PROJECT_DIR)mkdocs.yml

### Ignore Files. ###
DOCKER_IGNORE := $(PROJECT_DIR).dockerignore
GITIGNORE := $(PROJECT_DIR).gitignore
HADOLINT_IGNORE := $(PROJECT_DIR).hadolintignore
MARKDOWNLINT_IGNORE := $(PROJECT_DIR).markdownlintignore
NPM_IGNORE := $(PROJECT_DIR).npmignore
PRETTIER_IGNORE := $(PROJECT_DIR).prettierignore
SHELLCHECK_IGNORE := $(PROJECT_DIR).shellcheckignore
STYLELINT_IGNORE := $(PROJECT_DIR).stylelintignore

### Constants. ###
NPM_INSTALL_INSTRUCTIONS := "Please install NodeJS and npm from: https://docs.npmjs.com/downloading-and-installing-node-js-and-npm."
POETRY_INSTALL := "Please install from: https://python-poetry.org/docs/#installation"
HADOLINT_INSTALL := "Please install from: https://github.com/hadolint/hadolint"
PYTHON_INSTALL_INSTRUCTIONS := "Please install from: https://github.com/hadolint/hadolint"

### Regex Patterns. ###
PYTHON_REGEX := '*.py'
DOCKERFILE_REGEX := '*Dockerfile*'
SHELL_SCRIPT_REGEX := '*.sh *.bash *ksh'
STYLE_SHEETS_REGEX := '*.css *.scss'
MARKDOWN_REGEX := '**/*.md' '!**/node_modules/**/*.md'

# ----------------------------------------------------------------------------
# Function:  NPM
# Returns:   Returns the path to the npm executable.
# ----------------------------------------------------------------------------
define NPM
$(call executable,npm,$(NPM_INSTALL_INSTRUCTIONS))
endef

#NODE_MODULES := $(shell $(NPM) --prefix $(PROJECT_DIR) root)
#NODE_MODULES_PREFIX := $(shell $(NPM) bin)

# ----------------------------------------------------------------------------
# Function:  PERL
# Returns:   Returns the path to the perl executable.
# ----------------------------------------------------------------------------
define PERL
$(call executable,perl,$(PERL_INSTALL_INSTRUCTIONS))
endef

# All Makefile Targets #
ALL_TARGETS := $(shell $(PERL) -ne'print "$$1\n" if /^([^\.][\w\.]*):/' $(PROJECT_MAKEFILE))

define activate_venv
. $(VENV_ACTIVATE)
endef

### Poetry Executable ###
define POETRY
$(call executable,poetry,$(POETRY_INSTALL_INSTRUCTIONS))
endef

define venv_exists
$(shell $(POETRY) env info --path 2> $(DEVNUL))
endef

define python_env
$(POETRY) env info
endef

define virtualenv
$(POETRY) install --no-root
endef

### Function: __python_executable
### DESC: Helper function to find the executable path and display an error message if it's not found.
### ARGS $1: The python executable name.
### ARGS $2 (Optional): The message to display if the executable is undefined.
define __python_executable
$(if ($(call activate_venv); $(WHICH) $(1)),$(call activate_venv); $(WHICH) $(1),$(error Undefined $(1) $(if $(2), ($(2))) $(if $(value @),required by target `$@`)))
endef

define python_executable
$(if $(call venv_exists), \
$(shell $(call activate_venv); $(call __python_executable,$(1),$(2))), \
$(error Virtual environment not found. Please install using `poetry install --no-root`.))
endef

### Python Executable From Virtual Environment ###
define PYTHON
$(call python_executable,python3,$(PYTHON_INSTALL_INSTRUCTIONS))
endef

define poetry_sort
$(POETRY) sort
endef

### Hadolint Executable ###
define HADOLINT
$(call executable,hadolint,$(HADOLINT_INSTALL))
endef

define NPX
$(shell $(WHICH) npx)
endef

define SHELLCHECK
$(shell $(WHICH) shellcheck)
endef

define HADOLINT_FILES
$(shell $(PYTHON) $(FILE_FINDER) $(PROJECT_DIR) $(DOCKERFILE_REGEX) $(HADOLINT_IGNORE))
endef

define SHELLCHECK_FILES
$(shell $(PYTHON) $(FILE_FINDER) $(PROJECT_DIR) $(SHELL_SCRIPT_REGEX) $(SHELLCHECK_IGNORE))
endef

### Hadolint ###
## Dockerfile Linter ##
define hadolint
$(HADOLINT) --config $(HADOLINT_CONFIG) $(HADOLINT_FILES)
endef

### Shellcheck ###
## Shell Script Linter ##
define shellcheck
$(SHELLCHECK) $(SHELLCHECK_FILES)
endef

### Codespell ###
## Check code for common spelling mistakes ##
define codespell
$(POETRY) run codespell --config $(CODESPELL_CONFIG)
endef

### Pylama ###
## Code audit tool for Python ##
pylama = cd $(API_ROOT); $(POETRY) run pylama --option

### Function: PYLIC
### DESC: pylic executable.define
define PYLIC
$(call python_executable,pylic,$(PYTHON_INSTALL_INSTRUCTIONS))
endef

define pylic
cd $(API_ROOT); $(PYLIC) check --allow-extra-safe-licenses --allow-extra-unused-packages
endef

### pylic ###
## Python License Checker ##
#pylic = cd $(API_ROOT); $(POETRY) run pylic

define help
egrep '^[a-zA-Z_-]+:.*?## .*??' $(PROJECT_MAKEFILE) | sort | awk 'BEGIN {FS = ":.*?## "}; \
{printf "    $(CYAN)%-20s$(RESET_COLOR) %s\n", $$1, $$2}'
endef
