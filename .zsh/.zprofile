#!/usr/bin/env zsh

# Configure environment variables without any plusings

# >>> Set the zsh variables >>>
ZDOTDIR="${HOME}/.zsh"
export HISTFILE=$ZDOTDIR/history
export HISTORY_IGNORE=''
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export FPATH=$FPATH:$HOME/.zsh/complete
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64" # Compilation flags
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH
# <<< Set the zsh variables <<<

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"
echo "read .zprofile from ${HOME}/.zsh"


#######################
# Mark as loaded file #
#######################
alias zsh_pr_loaded='echo "zsh_profile_loaded"'