---
name: tmux-attention
description: Install a subtle visual signal in tmux so it's obvious when Claude Code is waiting for the user. The pane background tints gray when Claude finishes a turn or blocks for input, and clears when the user focuses the pane or submits a prompt. Use when setting up Claude Code on a new machine, or when the user mentions "tmux attention", "pane signal", or "know when Claude needs me".
---

# tmux-attention

Visual signal for Claude Code sessions running inside tmux.

## What it does

| Event | Pane background |
|---|---|
| Claude finishes its turn (`Stop` hook) | gray, unless the pane is already in focus |
| User focuses the pane (tmux `pane-focus-in`) | cleared |
| User submits a prompt (`UserPromptSubmit` hook) | cleared (backup for terminals without focus events) |

Also enables a pane-border header showing `pane_index: pane_title`. Claude Code automatically writes the current session topic into the pane title, so every Claude pane self-labels with what it's working on.

## How to install

The skill ships an idempotent installer. To use it from a Claude Code session, ask Claude to run:

```bash
bash ~/fun/scripts/.claude/skills/tmux-attention/install.sh
```

Or, on a fresh machine, after cloning `qnkhuat/scripts`:

```bash
bash ~/fun/scripts/.claude/skills/tmux-attention/install.sh
```

The installer:

1. Copies `tmux-attention.sh` to `~/.claude/hooks/tmux-attention.sh`.
2. Appends pane-header + focus-clear config to `~/.tmux.conf` (sentinel-marked, won't duplicate on re-run).
3. Patches `~/.claude/settings.json` to register `Stop` and `UserPromptSubmit` hooks. Idempotent — skips if `tmux-attention.sh` is already referenced.
4. Reloads tmux if running.

**Requirements:** `tmux`, `jq`, and a terminal emulator that reports focus events (iTerm2, Alacritty, kitty, WezTerm, recent Terminal.app all do).

## Tuning

- Change the gray shade in `tmux-attention.sh` — `colour237` is subtle; `colour236` is barely-there; `colour238`+ are louder.
- If you don't want the always-on pane header, remove the `set -g pane-border-status top` line from `~/.tmux.conf`.

## Uninstall

Delete the sentinel-marked block from `~/.tmux.conf`, remove entries referencing `tmux-attention.sh` from `~/.claude/settings.json`, and delete `~/.claude/hooks/tmux-attention.sh`.
