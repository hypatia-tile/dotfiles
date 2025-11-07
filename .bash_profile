#!/bin/bash

export HISTCONTROL=ignoreboth
# HISTFILESIZE is set larger than HISTSIZE so that more history is preserved across sessions
# than is available in a single session. This allows for a longer persistent history.
export HISTFILESIZE=2000
export HISTIGNORE="*.bash_history*:*mount*-o*password=*"
export HISTSIZE=1000
export HISTTIMEFORMAT='%Y/%m/%d %H:%M '
export ZDOTDIR=~/.zsh

# Export PATHs
export PATH="/usr/bin:$PATH"
export PATH="/snap/bin:$PATH"
export PATH="$HOME/anaconda3/bin:$PATH"
export PATH=$PATH:/opt/gradle/gradle-8.10.2/bin
export PATH="$PATH:$HOME/neovim/bin"

alias bash_profile_loaded='echo "bash_profile_loaded"'
export PATH="$HOME/.elan/bin:$PATH"
