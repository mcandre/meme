# meme: a package manager for GNUMakefile's

It's pronounced "may-may"~

# ABOUT

meme ("may-may") is a bare bones package manager for make, written in make. meme strives for wide cross-platform support, to encourage make configurations to "just work" on Unix and Windows systems, from pure GNU Linux to FreeBSD and macOS unix systems, to cygwin environments. A tall order for a build system that lacks logical conjugation!

As a bonus, meme itself is safe for inclusion from other Makefile's, providing helpful cross-platform variables such as `MEME_RM` and `MEME_SEP` for reuse. Be sure to include the meme Makefile thusly, to ensure that the include path itself is cross-platform:

```make
include $(MEME_PATH)

include $(MEME_ADDON_HOME)$(MEME_SEP)mcandre$(MEME_SEP)smolbean$(MEME_SEP)Makefile
```

Where `MEME_PATH` and `MEME_ADDON_HOME` are environment variables configured to resolve to the absolute locations of the meme files.

# EXAMPLES

```console
$ make -f $MEME_PATH meme_install meme_package=mcandre/smolbean

$ make -f $MEME_ADDON_HOME/mcandre/smolbean/Makefile pls
@

$ echo "include \$(MEME_ADDON_HOME)\$(MEME_SEP)mcandre\$(MEME_SEP)smolbean\$(MEME_SEP)Makefile" > Makefile
$ make pls
@

$ make -f $MEME_PATH meme_uninstall meme_package=mcandre/smolbean

$ make -f $MEME_PATH meme_version
0.0.1
```

# INSTALL via POSIX shells (sh, bash, zsh, ksh, etc.)

## Configure environment variables

Add a snippet like this to your shell configuration, such as in `$HOME/.bashrc`:

```sh
export MEME_HOME="$HOME/meme"
export MEME_PATH="$MEME_HOME/Makefile"
export MEME_ADDON_HOME="$HOME/.memes"
```

Then reload your shell configuration, such as:

```sh
. "$HOME/.bashrc"
```

## Download meme files

```console
C:\> git clone https://github.com/mcandre/meme.git "$MEME_HOME" && \
    mkdir -p "$MEME_ADDON_PATH"
```

# INSTALL via cmd.exe

## Configure environment variables

```console
C:\> setx MEME_HOME %HOMEDRIVE%%HOMEPATH%\meme
C:\> setx MEME_PATH %HOMEDRIVE%%HOMEPATH%\meme\Makefile
C:\> setx MEME_ADDON_HOME %HOMEDRIVE%%HOMEPATH%\.memes
```

Then sign out and sign back into your Windows account to reload shell configuration,
in order to propagate the updated environment variables to other terminal windows.

## Download meme files

```console
C:\> git clone https://github.com/mcandre/meme.git %MEME_HOME% &^
    mkdir %MEME_ADDON_HOME% &^
    reg import %MEME_HOME%\cmd-enable-extensions.reg
```

# INSTALL via powershell.exe

## Configure environment variables

```console
PS C:\> [Environment]::SetEnvironmentVariable("MEME_HOME", "$Env:HOMEDRIVE$Env:HOMEPATH\meme", "User")
PS C:\> [Environment]::SetEnvironmentVariable("MEME_PATH", [Environment]::GetEnvironmentVariable("MEME_HOME", "User"), "User")
PS C:\> [Environment]::SetEnvironmentVariable("MEME_ADDON_HOME", "$Env:HOMEDRIVE$Env:HOMEPATH\.memes", "User")
```

Then sign out and sign back into your Windows account to reload shell configuration,
in order to propagate the updated environment variables to other terminal windows.

## Download meme files

```console
PS C:\> git clone https://github.com/mcandre/meme.git ~/meme; `
if ($?) { mkdir -p ~/.memes } `
if ($?) { reg import ~/meme/cmd-enable-extensions.reg }
```

# REQUIREMENTS

* [GNU make](https://www.gnu.org/software/make/)
* [git](https://git-scm.com/)

# NOTABLE ALTERNATIVES

## Dedicated shell scripts

While any particular `*.sh`, `*.py`, or `*.bat` script still requires on a (ba)sh, Python, or cmd.exe interpreter, moving command line snippets out of Makefile's and into dedicated script files helps to make the overall build system for a project much more clearly defined. Instead of relying on GNU coreutil or bash features from within the Makefile itself, which often leads to implicit (read: hazardous) dependencies, hosting command line snippets in dedicated scripts creates clear dependency boundaries, so that project contributors can tease apart which portions of the build system depend on which environment configurations. Often, the main dependency of a complicated Makefile is just bash, so Windows developers can help themselves by activating the Windows Linux Subsystem and invoking `make` from within a "bash on Ubuntu on Windows" terminal. When in doubt, move complex logic out of your Makefile and into a dedicated shell script, which the Makefile then invokes.

## Generated Makefile's

Writing reliable cross-platform Makefile's is hard, and honestly writing basic platform locked Makefile's is also quite hard. So build systems like CMake and autotools/automake encourage developers to instead author build configurations in a more modern configuration language, which then compiles to a robust configuration in the Makefile language. This helps, for example, with configuring C compiler agnostic build systems that work with both gcc and clang; and with architecture agnostic build systems so that ports specific to x86_64, x86, ARM, etc. can be relatively easily managed. However, CMake and autotools tend to focus on targetting specific underlying tools, so for example autotools really requires a bash shell, and CMake in Windows prefers to generate Visual Studio artifacts rather than Makefile's. So they attack the problem of cross-platform build systems differently than meme, by relegating the role Makefile to a generated, and unix-specific domain. Developers interested in having the Makefile's themselves be cross-platform, must look elsewhere.

* [CMake](https://cmake.org/)
* [autotools](https://www.gnu.org/software/automake/)

## DSL-based build systems

Whereas `make` encourages direct command line execution, DSL-based build systems encourage cross-platform plugins, which do not rely on particular syntaxes and features of command line shells. They're a great way to easily promote cross-platform development setups! The trick is to rewrite every command line tool you would have used, as a plugin instead, which does take some time and effort.

* [gradle](https://gradle.org/)
* [Gulp](https://gulpjs.com/)

## Neutral shell interpreters

In theory, fish, batsh, python, and other platform agnostic interpreters could be assigned to the `SHELL` variable in Makefile's, so that commands are interpreted in a more platform agnostic way than `SHELL=/bin/sh`, `SHELL=cmd.exe`, etc. would behave. However, this requires installing additional development components, and would lead to headaches with how Makefile's interpret any included third party Makefile's.
