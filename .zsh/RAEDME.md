# zsh configuration

This directory take ZDOTDIR approach to store zsh configuration files in a separate location.

Zsh allows you to set a single environment variable telling it where to find all its startup files.

In your `.zshenv` (the only file Zsh always reads, even in login shells):
```bash
export ZDOTDIR=$HOME/.zsh
```

Then you can put your `.zshrc`, `.zprofile`, `.zlogin`, `.zlogout`, and `.zshenv` files in this directory.