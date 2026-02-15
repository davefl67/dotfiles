# 90-banner.sh — SSH-only banner

# Only run for interactive SSH sessions
[[ $- == *i* ]] || return
[[ -n "${SSH_CONNECTION:-}" ]] || return
[ -t 1 ] || return

PF_COLOR=1
clear

if command -v figlet >/dev/null 2>&1; then
  figlet -f slant "$HOSTNAME"
else
  echo "$HOSTNAME"
fi

if command -v pfetch >/dev/null 2>&1; then
  pfetch
elif command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi

echo "         1         2         3         4         5         6         7         8"
echo "────────────────────────────────────────────────────────────────────────────────"
echo "         0         0         0         0         0         0         0         0"
