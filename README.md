# meme: a package manager for Makefile's

It's pronounced "may-may"~

# ABOUT

meme ("may-may") is a bare bones package manager for make, written in make. meme strives for wide cross-platform support, to encourage make configurations to "just work" on Unix and Windows systems. A tall order for a build system that lacks logical conjugation!

# EXAMPLES

```console
$ make -f ~/meme/Makefile install package=mcandre/smolbean

$ make -f ~/.memes/mcandre/smolbean/Makefile pls
@

$ echo "include ~/.memes/mcandre/smolbean/Makefile" > Makefile
$ make pls
@

$ make -f ~/meme/Makefile uninstall package=mcandre/smolbean

$ make -f ~/meme/Makefile version
0.0.1
```

# INSTALL (bash-like shells, including bash, zsh, ksh, dash, posh, and fish)

```console
$ git clone https://github.com/mcandre/meme.git ~/meme
```

## BSD Note

macOS and other BSD users will need GNU coreutils as well, such as via [Homebrew](https://brew.sh/):

```console
$ brew install coreutils
```

Or by ports:

```console
$ port install coreutils
```

# INSTALL (POSIX shells)

```console
$ git clone https://github.com/mcandre/meme.git "$HOME/meme" && \
    mkdir -p "$HOME/.memes"
```

# INSTALL (PowerShell)

```console
$ git clone https://github.com/mcandre/meme.git ~/meme; `
if ($?) { mkdir -p ~/.memes } `
if ($?) { reg import ~/meme/cmd-enable-extensions.reg }
```

# INSTALL (cmd.exe)

```console
$ git clone https://github.com/mcandre/meme.git %HOMEDRIVE%%HOMEPATH%\meme &^
    mkdir %HOMEDRIVE%%HOMEPATH%\.memes &^
    reg import %HOMEDRIVE%%HOMEPATH\meme\cmd-enable-extensions.reg
```

# REQUIREMENTS

* [make](https://www.gnu.org/software/make/)
* [git](https://git-scm.com/)
