#!/usr/bin/env zsh
#
# Setup script for currency-exchange skill.
# Symlinks skill to global Claude Code and Codex CLI skill directories.
#

set -euo pipefail

SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_NAME="currency-exchange"

# --- Colors ---
red()   { print -P "%F{red}$1%f" }
green() { print -P "%F{green}$1%f" }
yellow(){ print -P "%F{yellow}$1%f" }

# --- Symlink to skill directory ---
symlink_skill() {
  local dir="$1"
  local link="$dir/$SKILL_NAME"

  mkdir -p "$dir"

  if [[ -L "$link" ]]; then
    local existing
    existing="$(readlink "$link")"
    if [[ "$existing" == "$SKILL_DIR" ]]; then
      green "Symlink already correct: $link -> $SKILL_DIR"
      return
    fi
    yellow "Updating symlink (was: $existing)"
    rm "$link"
  elif [[ -e "$link" ]]; then
    red "$link exists and is not a symlink. Skipping."
    return
  fi

  ln -s "$SKILL_DIR" "$link"
  green "Symlinked: $link -> $SKILL_DIR"
}

# --- Run ---
print ""
green "=== currency-exchange skill setup ==="
print ""

symlink_skill "$HOME/.claude/skills"
symlink_skill "$HOME/.codex/skills"

print ""
green "=== Done ==="
