# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a cross-platform dotfiles repository for managing Linux and macOS configurations. It includes shell configurations (Bash/Zsh), terminal emulator configs (Alacritty, Kitty), tmux, Neovim, Emacs, window management (AeroSpace, Hammerspoon), git, and LaTeX settings. The repository uses a symlink-based deployment system.

## Installation and Deployment

### Primary Command

```bash
./bin/dot-link.sh
```

This script symlinks dotfiles from this repository to `$HOME`. **Warning**: It forcefully overwrites existing dotfiles (it asks for confirmation first, then force-removes targets before linking).

### How dot-link.sh Works

The script performs two types of symlinking:

1. **Root-level dotfiles** (defined in `bin/target.txt`):
   - Removes then symlinks: `.bash_profile`, `.bashrc`, `.latexmkrc`, `.hammerspoon`, `.emacs.d`, `.envrc`
   - Symlinks from repository root to `$HOME`

2. **Config directory entries** (defined in `bin/configtarget.txt`):
   - Removes then symlinks: `nvim`, `alacritty`, `kitty`, `tmux`, `zsh`, `aerospace`, `git`
   - Symlinks from `.config/` in repository to `$HOME/.config/`

### Manual Bootstrap Step (not handled by dot-link.sh)

Zsh configuration lives in `.config/zsh/` using the ZDOTDIR approach. For zsh to find it, `~/.zshenv` must exist with:

```bash
export ZDOTDIR="$HOME/.config/zsh"
```

This file is created manually (it is not part of the repository or the symlink script).

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
│   ├── nvim/             # Neovim configuration (git submodule, LazyVim-based)
│   ├── zsh/              # Zsh configuration (ZDOTDIR)
│   │   ├── .zprofile    # Shell variables, history, fpath
│   │   ├── .zshrc       # Loads modules, completion, prompt
│   │   ├── modules/     # Modular configs (aliases, exports, abbr, vimode)
│   │   ├── complete/    # Custom completion/utility scripts (gitutils)
│   │   ├── functions/   # Autoloaded functions (repos)
│   │   └── abbr-definitions.zsh  # zsh-abbr abbreviations
│   ├── aerospace/        # AeroSpace tiling window manager (macOS)
│   ├── alacritty/        # Alacritty terminal config
│   ├── kitty/            # Kitty terminal config
│   ├── tmux/             # Tmux configuration
│   └── git/              # Git config, ignore, commit template
├── .emacs.d/             # Emacs configuration (init.el)
├── .hammerspoon/         # Hammerspoon window manager (macOS)
├── .bash_profile          # Bash login shell config
├── .bashrc               # Bash interactive shell config
├── .envrc                # direnv config for $HOME (PATH entries, env vars)
└── .latexmkrc            # LaTeX compilation settings
```

## Shell Configuration

### Zsh (Primary Shell)

**Loading order**:
1. `~/.zshenv` - Sets `ZDOTDIR=$HOME/.config/zsh` (manual bootstrap, see above)
2. `.config/zsh/.zprofile` - History settings, fpath, shell variables
3. `.config/zsh/.zshrc` - Sources all `.config/zsh/modules/*.zsh` files, sets up completion and prompt
4. `~/.zshrc_env` (if exists) - User-specific environment variables
5. `~/.zshrc_private` (if exists) - Private/local settings

**Key Features**:
- Modular configuration via `modules/*.zsh` files (automatically sourced)
- Custom prompt with git branch via vcs_info and vi-mode indicator
- **Vi mode** (`modules/vimode.zsh`): `bindkey -v`, mode indicator in prompt (`[INS]`/normal), cursor shape switching, `KEYTIMEOUT=1`
- Custom completions in `complete/`, autoloaded functions in `functions/`
- `repos` - fzf-based repository switcher over `ghq list`
- `gcwb` (in `complete/gitutils`) - Creates timestamped git work branch `work/YYYYMMDD_HHMMSS`
- `direnv` integration for per-directory environments
- **zsh-abbr** (`modules/abbr.zsh`): Fish-style command abbreviations (installed via Homebrew, symlinked to `~/.local/bin/zsh-abbr.zsh`)
  - Press Space after abbreviation to expand (e.g., `gs` → `git status`)
  - Abbreviations defined in `.config/zsh/abbr-definitions.zsh`
  - `abbr list` / `abbr add <key>=<expansion>` / `abbr erase <key>`
  - `abbr-reload` - Reload abbreviations from `abbr-definitions.zsh` after editing
  - See https://zsh-abbr.olets.dev/ for full documentation

**PATH Management**:
- PATH is managed by **nix-darwin** via `home.sessionPath` in `~/github/nix-darwin/nix/home/base.nix` — not by this repository's zsh files
- The repository's `.envrc` (symlinked to `~/.envrc`) also prepends PATH entries (Homebrew, Nix, LLVM, per-user profiles) via direnv
- For project-specific PATH modifications, use `.envrc` files with direnv
- Stack compiler bin helper: `add_stack_compiler_bin_to_path` (defined in `.zprofile`)

### Bash

**Features**:
- Platform-specific clipboard aliases (pbcopy/pbpaste via xclip on Linux)
- ghcup, Cargo, Angular CLI integration
- `direnv` hook for project-specific environments
- Custom function: `gcwb` - Creates timestamped git work branch
- Aliases: `q` (exit), `reload` (source ~/.bashrc), `rel` (reload)

## Application Configurations

### Neovim (.config/nvim/)

Git submodule (`git@github.com:hypatia-tile/nvim-config.git`). See `.config/nvim/CLAUDE.md` for comprehensive Neovim-specific guidance. This is a LazyVim-based configuration with support for Haskell, Rust, TypeScript/Deno, LaTeX, and more.

### Emacs (.emacs.d/init.el)

package.el-based configuration (GNU/NonGNU ELPA + MELPA archives). Notable setup:
- **ddskk** (SKK Japanese input): `C-x C-j` toggles skk-mode, dictionary at `~/.config/skk/SKK-JISYO.L`
- Org mode tweaks (indented startup, hidden emphasis markers, inline images)
- Generated directories (`eln-cache`, backups, auto-saves) are gitignored

### AeroSpace (.config/aerospace/aerospace.toml)

macOS tiling window manager (primary window management).

**Key bindings** (main mode):
- `Cmd+H/J/K/L` - Focus window left/down/up/right
- `Cmd+Shift+H/J/K/L` - Move window left/down/up/right
- `Cmd+1`–`Cmd+9` - Switch workspace
- `Cmd+Minus`/`Cmd+Equal` - Resize smart -50/+50
- `Alt+Slash` - Tiles layout, `Alt+Comma` - Accordion layout

### Hammerspoon (.hammerspoon/init.lua)

macOS window management via Lua scripting (kept alongside AeroSpace).

**Hotkeys**:
- `Cmd+Alt+K` - Launch/focus Kitty terminal
- `Cmd+Alt+Arrow` - Move window to half (left/right/top/bottom)
- `Cmd+Alt+M` - Maximize window
- `Cmd+Alt+C` - Center window
- `Cmd+Alt+Ctrl+Arrow` - Move window to next/previous display
- `Cmd+Alt+R` - Reload Hammerspoon config

### Terminal Emulators

**Kitty** (.config/kitty/kitty.conf):
- Preferred terminal (referenced by Hammerspoon)

**Alacritty** (.config/alacritty/alacritty.toml):
- Alternative terminal emulator, TOML-based configuration

### Tmux (.config/tmux/tmux.conf)

Terminal multiplexer configuration. Integrates with Neovim for seamless pane navigation (see Neovim's tmux-nav plugin).

### Git (.config/git/)

- `config`: user identity, delta as pager (with zdiff3 conflict style), git-lfs filters, nvim as editor, `ghq` root at `~/ghqrepo`, commit template
- `ignore`: global gitignore
- `commit_template.txt`: commit message template

## Development Tools Integration

### Language Environments

**Haskell**: ghcup, Stack integration with `add_stack_compiler_bin_to_path` helper, haskell-language-server in Neovim

**Rust**: rustup/Cargo (Cargo env sourced in `.bashrc`)

**Nix**: Multi-user Nix installation; system-level environment (including PATH) managed by nix-darwin in `~/github/nix-darwin/`

**Other**: Node.js (nodebrew), LaTeX (latexmk), Java (JAVA_HOME pinned in `.envrc` to a Nix store path)

### direnv

Both bash and zsh load direnv hooks for automatic environment switching based on `.envrc` files, including the repository's own `.envrc` symlinked into `$HOME`.

## Platform-Specific Considerations

**macOS**:
- AeroSpace and Hammerspoon window management
- nix-darwin manages system environment and PATH
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

**Zsh**: Create a new `.zsh` file in `.config/zsh/modules/` (automatically sourced)
**Bash**: Add to `.bashrc` or create `.bash_aliases` (sourced if exists)

### Modifying Neovim Configuration

See `.config/nvim/CLAUDE.md` for detailed guidance. The Neovim config is a git submodule with its own documentation.

### LaTeX Setup

- Configuration in `.latexmkrc`
- Neovim has VimTeX integration with platform-specific PDF viewer selection
- See Neovim CLAUDE.md for LaTeX-specific keybindings

## Important Notes

- **Destructive deployment**: `dot-link.sh` force-removes existing dotfiles before symlinking
- **No backup mechanism**: The script does not back up existing configurations
- **Git submodule**: `.config/nvim` is a git submodule (clone with `--recurse-submodules` or run `git submodule update --init`)
- **ZDOTDIR bootstrap**: `~/.zshenv` must set `ZDOTDIR` manually; without it, zsh will not find this repository's configuration
- **Shell aliases as guards**: Both bash and zsh use aliases (`bash_profile_loaded`, `zsh_profile_loaded`) to prevent double-sourcing

## Environment Detection

The repository uses several environment detection patterns:
- Platform detection: `uname` in bash for Linux-specific features
- Command availability: `command -v` checks before setting up integrations
- File existence checks before sourcing optional configs (`~/.zshrc_env`, `~/.zshrc_private`)
