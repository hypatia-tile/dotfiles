#!/usr/bin/env zsh


# The order of loading
# 1. ~/.zsh/.zprofile
# 2. ~/.zsh/.zshrc
# 3. ~/.zshrc_env
# 4. ~/.zshrc_private

###################
# Check .zprofile #
###################
if [[ -z $(alias | grep zsh_profile_loaded) ]]; then
  source $ZDOTDIR/.zprofile
fi

# Load modular configurations
for module in $ZDOTDIR/modules/*.zsh; do
  [[ -f $module ]] && source $module
done

sed -e 's/:/\n/g' <(echo "$PATH")

autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

# Autoload user defined completion functions
autoload -Uz gitutils && gitutils

# TODO: Move functions to a separate module file later
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

alias zsh_rc_loaded='echo "zsh_rc_loaded"'
