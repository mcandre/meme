VERSION=0.0.1

SEP_UNIX=/
SEP_WINDOWS=\\

SEP=$(SEP_UNIX)

ifneq ($(filter %command.com,$(SHELL)),)
	SEP=$(SEP_WINDOWS)
endif

ifneq ($(filter %cmd.exe,$(SHELL)),)
	SEP=$(SEP_WINDOWS)
endif

ifneq ($(filter %fish%,$(SHELL)),)
	ifeq ($(OS),Windows_NT)
		SEP=$(SEP_WINDOWS)
	endif
endif

HOME_POSIX=$$HOME
HOME_BASH=~
HOME_CMD=%HOMEDRIVE%%HOMEPATH%

HOME=$(HOME_POSIX)

ifneq ($(filter %fish%,$(SHELL)),)
	HOME=$(HOME_BASH)
endif

ifneq ($(filter %command.com,$(SHELL)),)
	HOME=$(HOME_CMD)
endif

ifneq ($(filter %cmd.exe,$(SHELL)),)
	HOME=$(HOME_CMD)
endif

ifneq ($(filter %powershell%,$(SHELL)),)
	HOME=$(HOME_BASH)
endif

UNAME_LOWER := $(shell uname -a | tr "[:upper:]" "[:lower:]")

HOME_ABSOLUTE=$(realpath $(HOME))

ifneq ($(filter %msys,$(UNAME_LOWER)),)
	HOME_ABSOLUTE := $(shell cygpath -w $(HOME))
endif

RM_UNIX=rm -rf
RM_CMD=del /sq
RM_POWERSHELL=rm -r -Force

RM=$(RM_UNIX)

ifneq ($(filter %command.com,$(SHELL)),)
	RM=$(RM_CMD)
endif

ifneq ($(filter %cmd.exe,$(SHELL)),)
	RM=$(RM_CMD)
endif

ifneq ($(filter %fish%,$(SHELL)),)
	ifeq ($(OS),Windows_NT)
		RM=$(RM_CMD)
	endif
endif

ifneq ($(filter %powershell%,$(SHELL)),)
	RM=RM_POWERSHELL
endif

package_install_directory=$(HOME_ABSOLUTE)$(SEP).memes$(SEP)$(package)

ifneq ($(filter %msys,$(UNAME_LOWER)),)
  package_install_directory := $(shell cygpath -w $(HOME_POSIX)$(SEP_UNIX).memes$(SEP_UNIX)$(package))
endif

install:
	git clone https://github.com/$(package).git $(package_install_directory)

uninstall:
	-@$(RM) $(package_install_directory)

version:
	@echo "$(VERSION)"
