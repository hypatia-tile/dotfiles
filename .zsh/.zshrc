#!/usr/bin/env zsh


# The order of loading
# 1. ~/.zsh/.zprofile
# 2. ~/.zsh/.zshrc
# 3. ~/.zshrc_env
# 4. ~/.zshrc_private

###################
# Check .zprofile #
###################
if [[ -z $(alias | grep zsh_pr_loaded) ]]; then
  source $ZDOTDIR/.zprofile
fi

sed -e 's/:/\n/g' <(echo "$PATH")

plugins=(git)
# Set locale
export LANG=en_US.UTF-8
# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Example aliases
# alias zshconfig="mate ~/.zshrc"

# >>> My settings >>>
# >>> Add additional paths to the PATH environment variable. >>>
export PATH="/usr/local/bin:$PATH"
# Haskell setting
export PATH="$HOME/.ghcup/bin:$PATH"
# path to homebrew
export PATH="/opt/homebrew/bin:$PATH"
# path to nodebrew
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# Java setting
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$JAVA_HOME/bin:$PATH"
# Created by `pipx` on 2024-07-21 06:03:30
export PATH="$HOME/.local/bin:$PATH"
# add path to postgresql
export PATH="/opt/homebrew/opt/postgresql@14/bin:$PATH"
# add path to SWI Prolog
export PATH="/opt/homebrew/Cellar/swi-prolog/9.2.6/bin:$PATH"
# add path to wildfly
export Path="$HOME/wildfly/wildfly-34.0.0.Beta1/bin:$PATH"
# add path to llvm
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# add path to script
export PATH="$HOME/script:$PATH"
# <<< Add additional paths to the PATH environment variable. <<<

# Add aliases
alias ll="ls -lah"
# vsCode setting
alias code='open -a /Applications/Visual\ Studio\ Code.app'

# sdk manager
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH

export PATH=$(stack path --compiler-bin --silent):$PATH
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

function take_note () {
  local note_dir="$HOME/work/notes/diary"
  local note_file="$note_dir/$(date +"note%Y%m%d.adoc")"
  if [ ! -d $note_dir ]; then
    echo "Note dir did not exist!"
    return 1
  elif [ ! -f "$note_file" ]; then
    echo "Note file $note_file did not exist! create is?(y/N)"
    read yorn
    case "$yorn" in
      y|y)
        touch "$note_file"
        nvim "$note_file"
        ;;
      *)
        return 0
    esac
  else
    nvim "$note_file"
  fi
}

export PAGER=less
