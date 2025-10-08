#!/usr/bin/env zsh

# Configure environment variables without any plugins

# Set the zsh variables
ZDOTDIR="${HOME}/.zsh"
export HISTFILE=$ZDOTDIR/history
export HISTORY_IGNORE=''
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export FPATH=$FPATH:$HOME/.zsh/complete
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64" # Compilation flags

# PATH environment variable configuration
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@14/bin:$PATH"
export PATH="/opt/homebrew/Cellar/swi-prolog/9.2.6/bin:$PATH"
export PATH="$HOME/wildfly/wildfly-34.0.0.Beta1/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$HOME/script:$PATH"
export PATH=$(stack path --compiler-bin --silent):$PATH
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH=$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"
echo "read .zprofile from ${HOME}/.zsh"


#######################
# Mark as loaded file #
#######################
alias zsh_pr_loaded='echo "zsh_profile_loaded"'