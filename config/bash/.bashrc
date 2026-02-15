# ─────────────────────────────────────────────────────────────────────────────────
# =================================================================================
#                    /\/|   __   _                     _
#                   |/\/   / /  | |                   | |
#                         / /   | |__     __ _   ___  | |__    _ __    ___
#                        / /    | '_ \   / _` | / __| | '_ \  | '__|  / __|
#                       / / _   | |_) | | (_| | \__ \ | | | | | |    | (__
#                      /_/ (_)  |_.__/   \__,_| |___/ |_| |_| |_|     \___|
# ─────────────────────────────────────────────────────────────────────────────────
# ~/.bashrc — minimal loader (Dave modular)
# Keep this file boring. Put all customizations in ~/.bashrc.d/*.sh

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# Load modular config in lexical order
if [ -d "$HOME/.bashrc.d" ]; then
  for f in "$HOME/.bashrc.d/"*.sh; do
    [ -r "$f" ] && . "$f"
  done
fi
