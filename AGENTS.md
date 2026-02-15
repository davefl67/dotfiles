# AGENTS.md — Rules for Codex in this repo (Dave Terminal Standard)

## Mission
Help build a reproducible, minimal-server CLI foundation for Debian/Ubuntu that is:
- Bash-first
- Modular
- Reversible
- Safe by default

## Non-negotiables (do not break these)
- **Repo-only changes:** Do not edit anything outside this repository unless I explicitly ask.
- **No login surgery:** Never modify any system shell defaults.
- **Do not replace my shell config:** Never overwrite or restructure my existing `~/.bashrc` or `~/.bashrc.local`.
- **No Docker in bootstrap:** Do not install Docker, docker-compose, or add Docker repos. Docker is manual by design.
- **No dev runtimes in bootstrap:** Do not install Python/Node/Go/Rust toolchains unless explicitly requested.
- **No destructive commands:** Do not run or suggest commands that can damage the system (e.g., `rm -rf`, editing `/etc`, changing permissions broadly) without asking first.

## Shell structure (hard rules)
- **Do not modify** `~/.profile`, `~/.bash_profile`, `~/.bash_login`, or any login-shell flow.
- **Do not rewrite** `~/.bashrc` beyond keeping it a minimal interactive guard + loader.
  - `~/.bashrc` must remain: interactive check + source `~/.bashrc.d/*.sh` in lexical order.
- All custom shell behavior lives in `~/.bashrc.d/*.sh` modules only.

## Modular layout (expected modules)
- `00-env.sh` — exports only (NO secrets, NO command substitutions, do NOT set TERM)
- `10-aliases.sh` — aliases only + safe wrappers (ok: trash-cli `rm` wrapper, `rmp`)
- `20-functions.sh` — shell functions (ex/up/yy/zz)
- `30-completion.sh` — completions + bind settings; safe to source tool completions when command exists
- `40-tools.sh` — tool init (starship/zoxide/thefuck/atuin), must be gated:
  - only interactive shells (`$-` contains `i`)
  - only real TTY (`-t 1`)
  - TERM not dumb
  - no DEBUG traps, no xtrace
- `50-network.sh` — network helpers only (no command substitution exports; prefer functions)
- `60-package.sh` — package helpers; do NOT override `sudo()`; allow aliases for `apt -> nala`
- `90-banner.sh` — **SSH-only banner**:
  - must require `SSH_CONNECTION` + interactive + TTY
- `99-local.sh` — optional per-host settings; avoid secrets

## Security rules
- Never store API keys/tokens/secrets in `.bashrc`, `.bashrc.d`, or any file that is auto-sourced by the shell.
- If secrets are needed, use a documented, opt-in pattern (example file only), and keep real secrets out of git.

## Safety rails for changes
- Prefer changes that are additive and reversible.
- Never override core commands in surprising ways (no `sudo()` redefinition, no auto-start tmux/zellij).
- Avoid changes that could break existing workflows or introduce new bugs

## Execution & permissions
- **Do not run commands automatically.** If you need commands executed, list them first and wait for approval.
- Prefer small, reviewable changes. Avoid large refactors.

## Workflow expectations
For each task:
1. Propose a short plan (3–7 bullets).
2. Implement changes **only in the repo**.
3. Provide a summary:
   - Files changed
   - Why
   - Exact validation commands (read-only if possible)
4. Suggest a commit message.

## Project conventions
- Shell standard: **bash**
- Multiplexers: install allowed, **never auto-start** (`tmux`/`zellij` are manual)
- Package manager for Debian/Ubuntu: **nala** (use apt only to bootstrap nala if needed)
- Editor: **micro**
- Safer delete: **trash-cli**
  - `rm` should prefer `trash-put` *only when sourced via optional layer*
  - provide `rmp` for permanent delete (`command rm -i`)
- Avoid tool overlap unless requested:
  - fetch: `fastfetch` + `pfetch`
  - file managers: `mc`, `yazi`, `ranger`
  - pager baseline: `less`, plus `moar`
  - pager alternatives: `most`, `bat`
  - shell completion: `bash-completion`

## Environment conventions
- `EDITOR` and `VISUAL` default to `micro`.
- `PAGER` defaults to `less -FRX` for compatibility.
- `moar` may be aliased over `less` in interactive shells, but `PAGER` must remain a stable system default.
- `VIEWER` should follow `PAGER` unless explicitly required otherwise.
- Do not override `TERM`.
- Avoid unnecessary environment variables unless they are widely used
- Do not use `alias` for anything that could be done with functions or sourced scripts.
- Do not use `export` unless absolutely necessary (e.g for PATH modifications).
- Do not use `sudo` in scripts 

## Output style
- Be explicit. No vague instructions.
- If a change touches shell startup behavior, explain impact and how to undo it.

## Documentation
- Document all changes with comments or links to relevant documentation.