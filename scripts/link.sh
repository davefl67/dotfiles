#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"

backup_existing() {
  local target="$1"
  local backup="${target}.bak.${TIMESTAMP}"

  while [[ -e "$backup" || -L "$backup" ]]; do
    backup="${backup}.1"
  done

  mv "$target" "$backup"
  printf 'Backed up %s -> %s\n' "$target" "$backup"
}

link_file() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if [[ -L "$target" ]]; then
    local current
    current="$(readlink "$target")"
    if [[ "$current" == "$source" ]]; then
      printf 'OK: %s already linked\n' "$target"
      return
    fi
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    backup_existing "$target"
  fi

  ln -s "$source" "$target"
  printf 'Linked %s -> %s\n' "$target" "$source"
}

link_file "$REPO_ROOT/config/zsh/zshrc" "$HOME/.zshrc"
link_file "$REPO_ROOT/config/zsh/zshenv" "$HOME/.zshenv"
link_file "$REPO_ROOT/config/starship/starship.toml" "$HOME/.config/starship.toml"
link_file "$REPO_ROOT/config/tmux/tmux.conf" "$HOME/.tmux.conf"
link_file "$REPO_ROOT/config/git/.gitconfig" "$HOME/.gitconfig"
link_file "$REPO_ROOT/config/git/.gitignore_global" "$HOME/.gitignore_global"
link_file "$REPO_ROOT/config/btop/btop.conf" "$HOME/.config/btop/btop.conf"

printf 'Done.\n'
