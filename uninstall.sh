#!/bin/bash

# Dotfiles uninstallation script
# This script removes symlinks created by the install script

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)

echo -e "${GREEN}Dotfiles Uninstallation Script${NC}"
echo "================================"
echo "Detected OS: $OS"
echo ""

# Remove symlink if it points to our dotfiles
remove_symlink() {
    local target=$1
    local dotfiles_dir=$2
    
    if [ -L "$target" ]; then
        local link_source=$(readlink "$target")
        if [[ "$link_source" == "$dotfiles_dir"* ]]; then
            rm "$target"
            echo -e "  ${GREEN}✓${NC} Removed symlink: $target"
        else
            echo -e "  ${YELLOW}⊘${NC} Skipped (not managed by dotfiles): $target"
        fi
    elif [ -e "$target" ]; then
        echo -e "  ${YELLOW}⊘${NC} Skipped (not a symlink): $target"
    fi
}

# Remove common dotfiles symlinks
echo "Removing common dotfiles symlinks..."
for file in "$DOTFILES_DIR/common"/.*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        remove_symlink "$HOME/$filename" "$DOTFILES_DIR"
    fi
done

# Remove OS-specific dotfiles symlinks
echo ""
echo "Removing $OS-specific dotfiles symlinks..."
os_dir="$DOTFILES_DIR/$OS"
if [ -d "$os_dir" ]; then
    for file in "$os_dir"/.*; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            remove_symlink "$HOME/$filename" "$DOTFILES_DIR"
        fi
    done
fi

echo ""
echo -e "${GREEN}Uninstallation complete!${NC}"
echo ""
echo -e "${YELLOW}Note: Your backup files (if any) are still in ~/.dotfiles_backup_*${NC}"
echo "You can restore them manually if needed."
echo ""
