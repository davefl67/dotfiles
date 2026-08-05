#!/usr/bin/env bash
set -u

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_HINT="Run ./bootstrap/bootstrap-debian.sh from the repo root."
missing_required=0

print_present() {
  local label="$1"
  local version="$2"
  printf '✅ %s: %s\n' "$label" "$version"
}

print_missing() {
  local label="$1"
  printf '❌ %s: missing. %s\n' "$label" "$INSTALL_HINT"
  missing_required=1
}

version_first_line() {
  local cmd="$1"
  local flag="$2"
  local out

  out="$($cmd "$flag" 2>/dev/null | head -n 1 || true)"
  if [[ -n "$out" ]]; then
    printf '%s' "$out"
    return 0
  fi

  return 1
}

check_tool() {
  local label="$1"
  local cmd="$2"
  shift 2
  local flags=("$@")
  local version
  local flag

  if ! command -v "$cmd" >/dev/null 2>&1; then
    print_missing "$label"
    return
  fi

  for flag in "${flags[@]}"; do
    if version="$(version_first_line "$cmd" "$flag")"; then
      print_present "$label" "$version"
      return
    fi
  done

  print_present "$label" "present"
}

check_bat() {
  local cmd=""
  local version=""

  if command -v bat >/dev/null 2>&1; then
    cmd="bat"
  elif command -v batcat >/dev/null 2>&1; then
    cmd="batcat"
  else
    print_missing "bat/batcat"
    return
  fi

  if version="$(version_first_line "$cmd" "--version")"; then
    print_present "bat/batcat" "$version"
  else
    print_present "bat/batcat" "$cmd present"
  fi
}

check_symlink_into_repo() {
  local path="$1"
  local resolved

  if [[ ! -e "$path" && ! -L "$path" ]]; then
    printf '⚠️  %s: missing\n' "$path"
    return
  fi

  if [[ ! -L "$path" ]]; then
    printf '⚠️  %s: exists but is not a symlink\n' "$path"
    return
  fi

  resolved="$(readlink -f "$path" 2>/dev/null || true)"
  if [[ -z "$resolved" ]]; then
    printf '⚠️  %s: symlink target could not be resolved\n' "$path"
    return
  fi

  case "$resolved" in
    "$REPO_ROOT"/*)
      printf '✅ %s: symlink -> %s\n' "$path" "$resolved"
      ;;
    *)
      printf '⚠️  %s: symlink points outside repo -> %s\n' "$path" "$resolved"
      ;;
  esac
}

echo "Doctor check for: $REPO_ROOT"
echo

echo "Tool checks"
check_tool "nala" "nala" "--version"
check_tool "zsh" "zsh" "--version"
check_tool "starship" "starship" "--version"
check_tool "tmux" "tmux" "-V" "--version"
check_tool "fzf" "fzf" "--version"
check_tool "ripgrep (rg)" "rg" "--version"
check_bat
check_tool "zoxide" "zoxide" "--version" "-V"
check_tool "btop" "btop" "--version" "-v"
check_tool "micro" "micro" "--version"
check_tool "trash-put (trash-cli)" "trash-put" "--version" "-V"
check_tool "git" "git" "--version"

echo
echo "Symlink checks (best effort)"
check_symlink_into_repo "$HOME/.bashrc"
check_symlink_into_repo "$HOME/.bashrc.d"
check_symlink_into_repo "$HOME/.zshrc"
check_symlink_into_repo "$HOME/.zshenv"
check_symlink_into_repo "$HOME/.tmux.conf"
check_symlink_into_repo "$HOME/.config/starship.toml"
check_symlink_into_repo "$HOME/.gitconfig"
check_symlink_into_repo "$HOME/.gitignore_global"
check_symlink_into_repo "$HOME/.config/btop/btop.conf"

if [[ $missing_required -eq 0 ]]; then
  exit 0
fi

exit 1
