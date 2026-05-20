#!/bin/bash
# Install the tmux-attention signal for Claude Code.
#
# When Claude Code is waiting for you, the pane background tints gray.
# When you switch focus to the pane or submit a prompt, it clears.
#
# Idempotent — safe to run multiple times.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOKS_DIR="$HOME/.claude/hooks"
HOOK_SCRIPT="$HOOKS_DIR/tmux-attention.sh"
TMUX_CONF="$HOME/.tmux.conf"
SETTINGS="$HOME/.claude/settings.json"
SENTINEL="# === claude-tmux-attention (managed by qnkhuat/scripts skill) ==="

need() {
  command -v "$1" >/dev/null 2>&1 || { echo "error: missing '$1' — please install it"; exit 1; }
}

need tmux
need jq

# --- 1. Install the hook helper ----------------------------------------------
mkdir -p "$HOOKS_DIR"
cp "$SCRIPT_DIR/tmux-attention.sh" "$HOOK_SCRIPT"
chmod +x "$HOOK_SCRIPT"
echo "✓ hook installed: $HOOK_SCRIPT"

# --- 2. Append tmux config (idempotent via sentinel marker) ------------------
# Detect either the sentinel (skill-managed install) or a stray manual install
# (the focus-in hook line is distinctive enough to identify it).
if [ -f "$TMUX_CONF" ] && { grep -qF "$SENTINEL" "$TMUX_CONF" \
                            || grep -q "set-hook -g pane-focus-in" "$TMUX_CONF"; }; then
  echo "✓ tmux config: already patched"
else
  cat >> "$TMUX_CONF" <<EOF

$SENTINEL
# Show a header row at the top of each pane with pane index + title.
set -g pane-border-status top
set -g pane-border-format ' #{pane_index}: #{pane_title} '

# Clear the gray attention tint as soon as a pane gets focus.
# Calling tmux commands directly (no run-shell) keeps this near-instant.
# Note: focus-events intentionally left off — turning it on makes tmux forward
# focus-in/out escape sequences to panes, which tmux then sees as output and
# flags as "activity" on every claude pane you switch away from. The hook still
# fires for within-tmux pane navigation without it.
set-hook -g pane-focus-in 'set-option -pu window-style ; set-option -pu window-active-style'
# === claude-tmux-attention END ===
EOF
  echo "✓ tmux config appended: $TMUX_CONF"
fi

# --- 3. Patch Claude Code settings.json (idempotent) -------------------------
mkdir -p "$(dirname "$SETTINGS")"
[ -f "$SETTINGS" ] || echo '{}' > "$SETTINGS"

if grep -qF "tmux-attention.sh" "$SETTINGS"; then
  echo "✓ settings.json: already patched"
else
  tmp=$(mktemp)
  jq --arg sh "$HOOK_SCRIPT" '
    .hooks //= {} |
    .hooks.Notification = ((.hooks.Notification // []) + [
      {matcher: "permission_prompt", hooks: [{type: "command", command: ($sh + " on")}]},
      {matcher: "idle_prompt",       hooks: [{type: "command", command: ($sh + " on")}]},
      {matcher: "elicitation_dialog",hooks: [{type: "command", command: ($sh + " on")}]}
    ]) |
    .hooks.Stop = ((.hooks.Stop // []) + [
      {hooks: [{type: "command", command: ($sh + " on")}]}
    ]) |
    .hooks.UserPromptSubmit = ((.hooks.UserPromptSubmit // []) + [
      {hooks: [{type: "command", command: ($sh + " off")}]}
    ]) |
    .hooks.SessionStart = ((.hooks.SessionStart // []) + [
      {hooks: [{type: "command", command: ($sh + " off")}]}
    ])
  ' "$SETTINGS" > "$tmp" && mv "$tmp" "$SETTINGS"
  echo "✓ settings.json patched: $SETTINGS"
fi

# --- 4. Reload tmux if running -----------------------------------------------
if [ -n "${TMUX:-}" ]; then
  tmux source-file "$TMUX_CONF" 2>/dev/null && echo "✓ tmux reloaded"
fi

echo
echo "Done. Next time Claude Code finishes a turn in a tmux pane, the bg will gray out."
echo "Switch focus to the pane (or submit your next prompt) to clear it."
