# Skill: Bootstrap Base CLI

## Purpose
Install the base CLI toolset on minimal Debian/Ubuntu servers.

## Rules
- Never install Docker.
- Never modify login shell behavior.
- Use nala for APT operations.
- Do not install development runtimes.
- Do not modify ~/.profile or ~/.bashrc directly.

## Procedure
1. Update package lists.
2. Install required APT packages.
3. Install binary tools into ~/.local/bin.
4. Verify installation.
5. Output validation commands.

## Validation
User should run:
- fastfetch
- zellij --version
- micro --version
