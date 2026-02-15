# AGENTS.md — Rules for Codex in this repo (Dave Terminal Standard)

## Mission
Help build a reproducible, minimal-server CLI foundation for Debian/Ubuntu that is:
- Bash-first
- Modular
- Reversible
- Safe by default

## Non-negotiables (do not break these)
- **Repo-only changes:** Do not edit anything outside this repository unless I explicitly ask.
- **No login surgery:** Never modify `~/.profile`, `~/.bash_profile`, `~/.bash_login`, or system shell defaults.
- **Do not replace my shell config:** Never overwrite or restructure my existing `~/.bashrc` or `~/.bashrc.local`.
  - If shell integration is needed, use an *optional include* pattern (e.g., a file meant to be sourced from `.bashrc`), and document it.
- **No Docker in bootstrap:** Do not install Docker, docker-compose, or add Docker repos. Docker is manual by design.
- **No dev runtimes in bootstrap:** Do not install Python/Node/Go/Rust toolchains unless explicitly requested.
- **No destructive commands:** Do not run or suggest commands that can damage the system (e.g., `rm -rf`, editing `/etc`, changing permissions broadly) without asking first.

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

## Output style
- Be explicit. No vague instructions.
- If a change touches shell startup behavior, explain impact and how to undo it.
