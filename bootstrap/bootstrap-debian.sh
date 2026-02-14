#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PACKAGES=(
  zsh
  tmux
  git
  curl
  ca-certificates
  unzip
  fzf
  ripgrep
  bat
  zoxide
  btop
  trash-cli
  micro
)

installed_now=()
skipped_already_present=()
starship_status="already present"

is_pkg_installed() {
  local pkg="$1"
  dpkg -s "$pkg" >/dev/null 2>&1
}

ensure_nala() {
  if command -v nala >/dev/null 2>&1; then
    return
  fi

  echo "nala not found. Installing nala via apt-get fallback..."
  sudo apt-get update
  sudo apt-get install -y nala
}

install_packages() {
  local missing=()
  local pkg

  for pkg in "${PACKAGES[@]}"; do
    if is_pkg_installed "$pkg"; then
      skipped_already_present+=("$pkg")
    else
      missing+=("$pkg")
    fi
  done

  if [[ ${#missing[@]} -eq 0 ]]; then
    echo "All requested packages are already installed."
    return
  fi

  echo "Installing packages with nala: ${missing[*]}"
  sudo nala update
  sudo nala install -y "${missing[@]}"
  installed_now=("${missing[@]}")
}

install_starship_if_missing() {
  if command -v starship >/dev/null 2>&1; then
    return
  fi

  echo "Installing starship to ~/.local/bin..."
  mkdir -p "$HOME/.local/bin"
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
  starship_status="installed"
}

run_linker() {
  "$REPO_ROOT/scripts/link.sh"
}

print_summary() {
  echo
  echo "Bootstrap summary:"

  if [[ ${#installed_now[@]} -gt 0 ]]; then
    echo "- Packages installed now: ${installed_now[*]}"
  else
    echo "- Packages installed now: none"
  fi

  if [[ ${#skipped_already_present[@]} -gt 0 ]]; then
    echo "- Packages already present: ${skipped_already_present[*]}"
  else
    echo "- Packages already present: none"
  fi

  echo "- Starship: ${starship_status}"
  echo "- Dotfiles link step: ran scripts/link.sh"
}

ensure_nala
install_packages
install_starship_if_missing
run_linker
print_summary
