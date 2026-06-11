### Detect Operating System.
## Reference: https://gist.github.com/sighingnow/deee806603ec9274fd47 ##
ifeq ($(OS),Windows_NT)
	OPERATING_SYSTEM=WIN32

	# For Windows, set shell to 'ComSpec', which will point to cmd.exe.
	# The MAKESHELL variable will be used instead of the default SHELL variable.
	MAKESHELL=$(ComSpec)
	CURRENT_SHELL=$(MAKESHELL)
	ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
		CPU_ARCHITECTURE=AMD64
	endif
	ifeq ($(PROCESSOR_ARCHITECTURE),x86)
		CPU_ARCHITECTURE=IA32
	endif
else
	CURRENT_SHELL:=$(SHELL)
	UNAME_S:=$(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OPERATING_SYSTEM=LINUX
	endif
	ifeq ($(UNAME_S),Darwin)
		OPERATING_SYSTEM=OSX
	endif
	UNAME_P:=$(shell uname -p)
	ifeq ($(UNAME_P),x86_64)
		CPU_ARCHITECTURE=AMD64
	endif
	ifneq ($(filter %86,$(UNAME_P)),)
		CPU_ARCHITECTURE=IA32
	endif
	ifneq ($(filter arm%,$(UNAME_P)),)
		CPU_ARCHITECTURE=ARM
	endif
endif

### Initialization depending on operating system. ###
ifeq ($(OPERATING_SYSTEM),WIN32)
	NEWLINE ?= $(shell echo.)
	MV ?= move
	LS ?= dir
	RM ?= del
	WHICH ?= where
	DEVNUL ?= NUL
	SHELLSTATUS ?= %ERRORLEVEL%
	check_executable = cmd /c "(help $(1) > $(DEVNUL) || exit 0) && $(WHICH) $(1) > $(DEVNUL) 2> $(DEVNUL)"
else ifneq ($(filter $(OPERATING_SYSTEM),OSX LINUX),)
	NEWLINE ?= \n
	MV ?= mv -f
	LS ?= ls
	RM ?= rm -f
	WHICH ?= which
	DEVNUL ?= /dev/null
	SHELLSTATUS ?= $$?
	check_executable = $(shell command -v $(1) 2> $(DEVNUL))
else
$(error Unsupported Operating System...)
endif