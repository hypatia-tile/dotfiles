# zsh configuration

expected .zshrc file:
```zsh
#!/usr/bin/env zsh

export ZDOTDIR="${HOME}/.zsh"

if [ -d "${ZDOTDIR}" ] && [ -f "${ZDOTDIR}/.zshrc" ]; then
  echo "read from ${HOME}/.zsh"
  source "${HOME}/.zsh/.zshrc"
else
  source "${HOME}/.zshrc.local"
fi
```