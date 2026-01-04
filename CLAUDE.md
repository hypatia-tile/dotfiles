# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a cross-platform dotfiles repository for managing Linux and macOS configurations. It includes shell configurations (Bash/Zsh), terminal emulator configs (Alacritty, Kitty), tmux, Neovim, window management (Hammerspoon), and LaTeX settings. The repository uses a symlink-based deployment system.

## Installation and Deployment

### Primary Command

```bash
./bin/dot-link.sh
```

This script symlinks dotfiles from this repository to `$HOME`. **Warning**: It forcefully overwrites existing dotfiles.

### How dot-link.sh Works

The script performs two types of symlinking:

1. **Root-level dotfiles** (defined in `bin/target.txt`):
   - Removes existing files/directories: `.bash_profile`, `.bashrc`, `.zsh`, `.latexmkrc`, `.hammerspoon`
   - Symlinks from repository root to `$HOME`

2. **Config directory files** (defined in `bin/configtarget.txt`):
   - Removes existing directories: `nvim`, `alacritty`, `kitty`, `tmux`
   - Symlinks from `.config/` in repository to `$HOME/.config/`

### Modifying Symlink Targets

- Edit `bin/target.txt` to add/remove root-level dotfiles
- Edit `bin/configtarget.txt` to add/remove `.config/` entries
- Format: one path per line (paths are relative to repository root or `.config/` respectively)

## Repository Structure

```
.
├── bin/                    # Deployment scripts
│   ├── dot-link.sh        # Main symlink deployment script
│   ├── target.txt         # Root-level dotfiles to symlink
│   └── configtarget.txt   # .config/ entries to symlink
├── .config/               # XDG config directory
│   ├── nvim/             # Neovim configuration (LazyVim-based)
│   ├── alacritty/        # Alacritty terminal config
│   ├── kitty/            # Kitty terminal config
│   ├── tmux/             # Tmux configuration
│   └── git/              # Git configuration
├── .hammerspoon/         # Hammerspoon window manager (macOS)
├── .zsh/                 # Zsh shell configuration
│   ├── .zprofile        # Environment variables, PATH setup
│   ├── .zshrc           # Interactive shell config, loads modules
│   ├── modules/         # Modular zsh configs (aliases.zsh, exports.zsh)
│   └── complete/        # Custom completion scripts
├── .bash_profile         # Bash login shell config
├── .bashrc              # Bash interactive shell config
└── .latexmkrc           # LaTeX compilation settings
```

## Shell Configuration

### Zsh (Primary Shell)

**Loading order**:
1. `.zsh/.zprofile` - Environment setup, PATH configuration
2. `.zsh/.zshrc` - Sources all `.zsh/modules/*.zsh` files, sets up completion
3. `~/.zshrc_env` (if exists) - User-specific environment variables
4. `~/.zshrc_private` (if exists) - Private/local settings

**Key Features**:
- Modular configuration via `modules/*.zsh` files
- VCS info in prompt (git branch display)
- Custom completions in `.zsh/complete/`
- `direnv` integration for per-directory environments
- Custom function: `take_note` - Opens daily AsciiDoc note file

**PATH Management** (.zsh/.zprofile:18-44):
- Explicitly constructed PATH (not appending)
- Homebrew paths prioritized (`/opt/homebrew/bin`, `/opt/homebrew/sbin`)
- Language toolchains: Rust (rustup), Haskell (ghcup), Node (nodebrew), Nix, Elan (Lean)
- Stack compiler bin helper: `add_stack_compiler_bin_to_path`

### Bash

**Features**:
- Platform-specific clipboard aliases (pbcopy/pbpaste via xclip on Linux)
- ghcup, Cargo, Angular CLI integration
- `direnv` hook for project-specific environments
- Custom function: `gcwb` - Creates timestamped git work branch
- Aliases: `q` (exit), `reload` (source ~/.bashrc), `rel` (reload)

## Application Configurations

### Neovim (.config/nvim/)

See `.config/nvim/CLAUDE.md` for comprehensive Neovim-specific guidance. This is a LazyVim-based configuration with support for Haskell, Rust, TypeScript/Deno, LaTeX, and more.

### Hammerspoon (.hammerspoon/init.lua)

macOS window management via Lua scripting.

**Hotkeys**:
- `Cmd+Alt+K` - Launch/focus Kitty terminal
- `Cmd+Alt+Arrow` - Move window to half (left/right/top/bottom)
- `Cmd+Alt+M` - Maximize window
- `Cmd+Alt+C` - Center window
- `Cmd+Alt+Ctrl+Arrow` - Move window to next/previous display
- `Cmd+Alt+R` - Reload Hammerspoon config

**Architecture**:
- Simple configuration, no external dependencies
- Uses `hs.window`, `hs.geometry`, `hs.hotkey` modules
- Shows alert on config load/reload

### Terminal Emulators

**Kitty** (.config/kitty/kitty.conf):
- Preferred terminal (referenced by Hammerspoon)
- Configuration managed via kitty.conf

**Alacritty** (.config/alacritty/alacritty.toml):
- Alternative terminal emulator
- TOML-based configuration

### Tmux (.config/tmux/tmux.conf)

Terminal multiplexer configuration. Integrates with Neovim for seamless pane navigation (see Neovim's tmux-nav plugin).

## Development Tools Integration

### Version Control
- Git config in `.config/git/`
- Custom git function in bash: `gcwb` - Creates work branches with timestamp format `work/YYYYMMDD_HHMMSS`

### Language Environments

**Haskell**:
- ghcup managed via `~/.ghcup/bin`
- Stack integration with dynamic compiler bin PATH helper
- Neovim has haskell-language-server setup

**Rust**:
- rustup in `/opt/homebrew/opt/rustup/bin`
- Cargo env sourced in `.bashrc`

**Node.js**:
- nodebrew for version management
- Angular CLI completion in bash

**Nix**:
- Multi-user Nix installation (`/nix/var/nix/profiles/default/bin`)
- User profile: `~/.nix-profile/bin`
- NixOS integration: `/run/current-system/sw/bin`

**Other**:
- Lean (Elan): `~/.elan/bin`
- Ruby: Homebrew-managed
- Java: OpenJDK via Homebrew
- LLVM: Homebrew opt path

### direnv
Both bash and zsh load direnv hooks for automatic environment switching based on `.envrc` files in project directories.

## Platform-Specific Considerations

**macOS**:
- Hammerspoon window management
- Homebrew paths take priority in PATH
- Platform detection in bash for clipboard (skips xclip setup)

**Linux**:
- xclip for clipboard functionality (pbcopy/pbpaste aliases)
- Platform-specific terminal and PDF viewer choices (e.g., Zathura in LaTeX)

## Common Workflows

### Adding a New Dotfile

1. Place the dotfile/directory in the repository root or `.config/`
2. Add its path to `bin/target.txt` (for root-level) or `bin/configtarget.txt` (for .config/)
3. Run `./bin/dot-link.sh` to deploy

### Adding Shell Aliases or Functions

**Zsh**: Create a new `.zsh` file in `.zsh/modules/` (automatically sourced)
**Bash**: Add to `.bashrc` or create `.bash_aliases` (sourced if exists)

### Modifying Neovim Configuration

See `.config/nvim/CLAUDE.md` for detailed guidance. The Neovim config is a submodule/separate configuration with its own documentation.

### LaTeX Setup

- Configuration in `.latexmkrc`
- Neovim has VimTeX integration with platform-specific PDF viewer selection
- See Neovim CLAUDE.md for LaTeX-specific keybindings

## Important Notes

- **Destructive deployment**: `dot-link.sh` force-removes existing dotfiles before symlinking
- **No backup mechanism**: The script does not back up existing configurations
- **Git submodule**: `.config/nvim` appears to be a git submodule (has `.git` file)
- **Shell aliases as guards**: Both bash and zsh use aliases (`bash_profile_loaded`, `zsh_profile_loaded`) to prevent double-sourcing

## Environment Detection

The repository uses several environment detection patterns:
- Platform detection: `uname` in bash for Linux-specific features
- Command availability: `command -v` checks before setting up integrations
- File existence checks before sourcing optional configs (`~/.zshrc_env`, `~/.zshrc_private`)
