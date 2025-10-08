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
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$HOME/script:$PATH"

# To add the stack compiler bin to your PATH, run: add_stack_compiler_bin_to_path
add_stack_compiler_bin_to_path() {
  local stack_bin
  stack_bin=$(stack path --compiler-bin --silent 2>/dev/null)
  if [[ -n "$stack_bin" && ":$PATH:" != *":$stack_bin:"* ]]; then
    export PATH="$stack_bin:$PATH"
  fi
}
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"
# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"
echo "read .zprofile from ${HOME}/.zsh"


#######################
# Mark as loaded file #
#######################
alias zsh_profile_loaded='echo "zsh_profile_loaded"'