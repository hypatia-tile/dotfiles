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
# export PATH=

export PATH=
PATH="/sbin:$PATH"
PATH="/usr/sbin:$PATH"
PATH="/bin:$PATH"
PATH="/usr/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/opt/homebrew/sbin:$PATH"
PATH="/opt/homebrew/bin:$PATH"

PATH="/opt/homebrew/opt/llvm/bin:$PATH"
PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
PATH="/opt/homebrew/opt/ruby/bin:$PATH"
PATH="/opt/homebrew/opt/rustup/bin:$PATH"

PATH="${HOME}/.elan/bin:$PATH"
PATH="${HOME}/.local/bin:$PATH"
PATH="${HOME}/.nodebrew/current/bin:$PATH"
PATH="${HOME}/.ghcup/bin:$PATH"
PATH="${HOME}/.nix-profile/bin:$PATH"

PATH="${HOME}/Library/Android/sdk/tools/bin:$PATH"
PATH="${HOME}/Library/Android/sdk/platform-tools:$PATH"
PATH="${HOME}/script:$PATH"

PATH="/run/current-system/sw/bin:$PATH"
PATH="/nix/var/nix/profiles/default/bin:$PATH"

# To add the stack compiler bin to your PATH, run: add_stack_compiler_bin_to_path
add_stack_compiler_bin_to_path() {
  local stack_bin
  stack_bin=$(stack path --compiler-bin --silent 2>/dev/null)
  if [[ -n "$stack_bin" && ":$PATH:" != *":$stack_bin:"* ]]; then
    PATH="$stack_bin:$PATH"
  fi
}
#
# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

echo "read .zprofile from ${HOME}/.zsh"
#######################
# Mark as loaded file #
#######################
alias zsh_profile_loaded='echo "zsh_profile_loaded"'


