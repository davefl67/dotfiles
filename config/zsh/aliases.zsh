# Lean git quality-of-life aliases.
alias gs='git status -sb'
alias gl='git log --oneline --graph --decorate -n 20'

# Prefer lla when available.
if (( $+commands[lla] )); then
  alias ls='lla'
  alias ll='lla -lah'
fi

# Safe delete flow with trash-cli when available.
if (( $+commands[trash-put] )); then
  alias rm='trash-put'
  alias rmp='command rm -i'

  (( $+commands[trash-list] )) && alias tlist='trash-list'
  (( $+commands[trash-restore] )) && alias trestore='trash-restore'
  (( $+commands[trash-empty] )) && alias tempty='trash-empty'
else
  alias rmp='rm -i'
fi
