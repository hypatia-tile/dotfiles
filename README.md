# dotfiles

Manage configuration files (dotfiles) consistently and efficiently across Linux (Ubuntu) and macOS.

## Overview

This repository contains personal configuration files (dotfiles) organized for easy deployment across different systems. It uses a simple symlink-based approach to manage configurations, with support for both common and OS-specific settings.

## Features

- 🔗 **Symlink-based management**: Easy to maintain and update
- 🖥️ **Cross-platform support**: Works on both Linux (Ubuntu) and macOS
- 📁 **Organized structure**: Common and OS-specific configurations
- 💾 **Automatic backups**: Existing files are backed up before installation
- ✨ **Simple installation**: One command to set up everything

## Repository Structure

```
dotfiles/
├── common/           # Configuration files for all platforms
│   ├── .bashrc      # Shell configuration
│   ├── .gitconfig   # Git configuration
│   └── .vimrc       # Vim editor configuration
├── linux/           # Linux-specific configurations
│   └── .bashrc_local
├── macos/           # macOS-specific configurations
│   └── .bashrc_local
├── install.sh       # Installation script
├── uninstall.sh     # Uninstallation script
└── README.md        # This file
```

## Installation

### Prerequisites

- Bash shell
- Git

### Quick Start

1. Clone this repository:
   ```bash
   git clone https://github.com/hypatia-tile/dotfiles.git
   cd dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

3. Apply the changes:
   ```bash
   source ~/.bashrc
   ```

### What the Install Script Does

1. **Detects your OS** (Linux or macOS)
2. **Backs up existing dotfiles** to `~/.dotfiles_backup_YYYYMMDD_HHMMSS/`
3. **Creates symlinks** from your home directory to files in this repository
4. **Installs common dotfiles** that work on all platforms
5. **Installs OS-specific dotfiles** for your detected operating system

## Uninstallation

To remove all symlinks created by the install script:

```bash
./uninstall.sh
```

This will:
- Remove all symlinks that point to this dotfiles repository
- Leave your backup files intact for manual restoration if needed

## Customization

### Adding New Dotfiles

1. **For all platforms**: Add the file to the `common/` directory
2. **For a specific OS**: Add the file to `linux/` or `macos/` directory
3. Run `./install.sh` to create the symlink

### Modifying Configurations

Since dotfiles are symlinked, any changes you make to files in this repository will immediately take effect in your home directory. Remember to commit and push your changes!

### Personal Information

Before using these dotfiles, you may want to customize:
- `.gitconfig`: Update with your name and email
- `.bashrc`: Adjust aliases and prompt to your preference
- `.vimrc`: Modify editor settings as needed

## Included Configurations

### .bashrc
- History management
- Color support for ls and grep
- Common aliases (ll, la, l)
- Colored prompt
- Loads OS-specific configurations

### .gitconfig
- Common git aliases (st, co, br, ci, lg)
- Color output
- Better log formatting
- Safe push/pull defaults

### .vimrc
- Syntax highlighting
- Line numbers
- Mouse support
- Smart indentation
- Search highlighting
- UTF-8 encoding

### OS-Specific Configurations

**Linux (.bashrc_local)**:
- apt package manager shortcuts
- Bash completion

**macOS (.bashrc_local)**:
- Homebrew integration
- brew package manager shortcuts
- GNU coreutils support

## Contributing

Feel free to fork this repository and customize it for your own use. If you have suggestions for improvements, please open an issue or pull request.

## License

MIT License - See [LICENSE](LICENSE) file for details.
