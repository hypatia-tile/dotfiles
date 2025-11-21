#!/bin/bash

cat << EOF
****************** Warning *****************************
This script force overwrites dotfiles under $HOME.
********************************************************
Are you sure to continue? (y/N):
EOF
read yesno
if [ "$yesno" != "y" ]; then
    exit 0
fi

dotfiles_dir="$(pwd)"

echo "Removing dotfiles under $HOME"
cat "${dotfiles_dir}/bin/target.txt" | xargs -I {} rm -rf "${HOME}/{}" \
    && echo "Removed dotfiles under $HOME" \
    || { echo "Failed to remove dotfiles under $HOME"; exit 1; }

echo "starting linking dotfiles"
cat "${dotfiles_dir}/bin/target.txt" | xargs -I {} ln -s "${dotfiles_dir}/{}" "${HOME}/{}" \
    && echo "Linked dotfiles successfully" \
    || { echo "Failed to link dotfiles"; exit 1; }

echo "Removing config files under $HOME/.config"
cat "${dotfiles_dir}/bin/configtarget.txt" | xargs -I {} rm -rf "${HOME}/.config/{}" \
    && echo "Removed config files under $HOME/.config" \
    || { echo "Failed to remove config files under $HOME/.config"; exit 1; }

echo "starting linking config files"
cat "${dotfiles_dir}/bin/configtarget.txt" | xargs -I {} ln -s "${dotfiles_dir}/.config/{}" "${HOME}/.config/{}" \
    && echo "Linked config files successfully" \
    || { echo "Failed to link config files"; exit 1; }
