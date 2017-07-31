* Fix how the git clone command for installing packages somehow fails when run via make in Git Bash, but succeeds when directly executed in Git Bash.
* Separate bash, ksh, zsh, csh, tcsh, and fish environment configuration for the MEME environment variable, and bundle this setup, along with the download steps, in complete install shell scripts. Do the same for Command Prompt and PowerShell.
* Test how rmdir /s /q behaves when targeting non-folder files in Command Prompt and PowerShell environments.
* Test how meme behaves in native Unix environments and terminals, including bash, POSIX sh, zsh, ksh, and fish.
* Test how meme behaves in PowerShell terminals on Unix hosts.
* Provide bash, etc. aliases for convenience, so that `meme ...` expands to `make -f "$MEME_PATH" ...`
