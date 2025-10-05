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

dotfiles_dir="${HOME}/dotfiles"

echo "Removing dotfiles under $HOME"
cat "${dotfiles_dir}/bin/target.txt" | xargs -I {} rm -rf "${HOME}/{}" \
    && echo "Removed dotfiles under $HOME" \
    || { echo "Failed to remove dotfiles under $HOME"; exit 1; }

echo "starting linking dotfiles"
cat "${dotfiles_dir}/bin/target.txt" | xargs -I {} ln -s "${dotfiles_dir}/{}" "${HOME}/{}" \
    && echo "Linked dotfiles successfully" \
    || { echo "Failed to link dotfiles"; exit 1; }




