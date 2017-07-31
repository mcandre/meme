MEME_VERSION=0.0.1

#
# Assume pure unix environment unless other strange environments are detected.
#
MEME_SHELL=/bin/sh
MEME_SEP=/
MEME_MKDIR=mkdir -p
MEME_RM=rm -rf
meme_home_command=echo $$HOME

# The presence/absence of MEME_CYGWIN is also useful for managing paths
# in a platform agnostic way, especially when manipulating paths betweeen
# different CLI applications.

# Windows host
ifdef COMSPEC
	# Cygwin (unix) guest
	ifdef MSYSTEM
		MEME_CYGWIN=yes
	# Pure Windows guest
	else
		MEME_SHELL=cmd.exe
		MEME_SEP=\\
		MEME_MKDIR=mkdir
		MEME_RM=rmdir /s /q
		meme_home_command=echo %HOMEDRIVE%%HOMEPATH%
	endif
else
	uname=$(shell uname -a)

	# Windows Linux Subsystem AKA bash on Ubuntu on Windows, another cygwin-like (unix) guest
	ifneq ($(filter %Microsoft%,$(uname)),)
		MEME_CYGWIN=yes
	endif
endif

# Fix epic fail with how segfaulting Chocolatey sh.exe interacts with GNU make.exe.
SHELL=$(MEME_SHELL)

MEME_HOME=$(shell $(meme_home_command))

meme_package_local=$(meme_package)

ifeq ($(SHELL),cmd.exe)
	meme_package_local=$(subst /,\\,$(package))
endif

meme_package_install_directory=$(MEME_HOME)$(MEME_SEP).memes$(MEME_SEP)$(meme_package_local)

meme_check_package:
ifndef meme_package
	$(error Missing required make argument meme_package)
endif

meme_install: meme_check_package
	git clone https://github.com/$(meme_package).git $(meme_package_install_directory)

meme_uninstall: meme_check_package
	-$(MEME_RM) $(meme_package_install_directory)

meme_version:
	echo "$(MEME_VERSION)"
