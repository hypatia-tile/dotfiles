#!/bin/bash

# Dotfiles installation script for Linux (Ubuntu) and macOS
# This script creates symlinks from the home directory to the dotfiles in this repository

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

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

echo -e "${GREEN}Dotfiles Installation Script${NC}"
echo "================================"
echo "Detected OS: $OS"
echo "Dotfiles directory: $DOTFILES_DIR"
echo ""

if [ "$OS" == "unknown" ]; then
    echo -e "${RED}Error: Unsupported operating system${NC}"
    exit 1
fi

# Create backup directory if it doesn't exist
create_backup_dir() {
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
        echo -e "${GREEN}Created backup directory: $BACKUP_DIR${NC}"
    fi
}

# Backup existing file
backup_file() {
    local file=$1
    if [ -e "$file" ] || [ -L "$file" ]; then
        create_backup_dir
        echo -e "${YELLOW}Backing up existing file: $file${NC}"
        mv "$file" "$BACKUP_DIR/"
    fi
}

# Create symlink
create_symlink() {
    local source=$1
    local target=$2
    
    if [ -L "$target" ]; then
        local current_source=$(readlink "$target")
        if [ "$current_source" == "$source" ]; then
            echo -e "  ${GREEN}✓${NC} $target (already linked)"
            return
        fi
    fi
    
    backup_file "$target"
    ln -sf "$source" "$target"
    echo -e "  ${GREEN}✓${NC} Created symlink: $target -> $source"
}

# Install common dotfiles
echo "Installing common dotfiles..."
for file in "$DOTFILES_DIR/common"/.*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        create_symlink "$file" "$HOME/$filename"
    fi
done

# Install OS-specific dotfiles
echo ""
echo "Installing $OS-specific dotfiles..."
os_dir="$DOTFILES_DIR/$OS"
if [ -d "$os_dir" ]; then
    for file in "$os_dir"/.*; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            create_symlink "$file" "$HOME/$filename"
        fi
    done
else
    echo -e "${YELLOW}No OS-specific directory found for $OS${NC}"
fi

echo ""
echo -e "${GREEN}Installation complete!${NC}"
echo ""

if [ -d "$BACKUP_DIR" ] && [ "$(ls -A $BACKUP_DIR)" ]; then
    echo -e "${YELLOW}Your original dotfiles have been backed up to:${NC}"
    echo "  $BACKUP_DIR"
    echo ""
fi

echo "To apply the changes, please run:"
echo "  source ~/.bashrc"
echo ""
