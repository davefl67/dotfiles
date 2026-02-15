# 40-tools.sh — interactive tool init (gated)
# Keep this conservative. No auto-start multiplexers.

# Only run if interactive + real terminal
[[ $- == *i* ]] || return
[ -t 1 ] || return
[ -n "${TERM:-}" ] || return
[ "${TERM}" != "dumb" ] || return

# Starship (optional)
# If starship ever misbehaves again, comment this block out.
if command -v starship >/dev/null 2>&1; then
  # Compatibility: avoid fragile preexec behavior
  export STARSHIP_DISABLE_PREEXEC=1
  eval "$(starship init bash)"
fi

# thefuck (optional)
if command -v thefuck >/dev/null 2>&1; then
  eval "$(thefuck --alias)"
fi

# zoxide (optional)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

# atuin (optional; can be heavy)
if [ -r "$HOME/.atuin/bin/env" ]; then
  . "$HOME/.atuin/bin/env"
fi

# If bash-preexec exists, load it before atuin init
[ -r "$HOME/.bash-preexec.sh" ] && . "$HOME/.bash-preexec.sh"

# ---- ATUIN ----
if command -v atuin >/dev/null 2>&1; then
  [ -r "$HOME/.bash-preexec.sh" ] && . "$HOME/.bash-preexec.sh"
  unset ATUIN_NOBIND
  eval "$(atuin init bash)"
fi

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init bash)"
  # Optional keybindings (uncomment if desired)
  # bind -x '"\C-r": __atuin_history'
  # bind -x '"\e[A": __atuin_history --shell-up-key-binding'
  # bind -x '"\eOA": __atuin_history --shell-up-key_binding'
fi
