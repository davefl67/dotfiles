# 60-package.sh — package manager helpers (no sudo override)

# Prefer nala output formatting
if command -v nala >/dev/null 2>&1; then
  alias nala='sudo COLUMNS=90 nala'
  alias apt='sudo COLUMNS=90 nala'
fi
