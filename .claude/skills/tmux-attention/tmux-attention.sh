#!/bin/bash
# Toggle a subtle gray background on the current tmux pane to signal that
# Claude Code is waiting for the user. Called from Claude Code hooks.
#
# Usage: tmux-attention.sh on|off

[ -z "$TMUX_PANE" ] && exit 0
[ -z "$TMUX" ] && exit 0

ATTENTION_BG="bg=colour237"

case "$1" in
  on)
    tmux set-option -p -t "$TMUX_PANE" window-style "$ATTENTION_BG" 2>/dev/null
    tmux set-option -p -t "$TMUX_PANE" window-active-style "$ATTENTION_BG" 2>/dev/null
    ;;
  off)
    tmux set-option -pu -t "$TMUX_PANE" window-style 2>/dev/null
    tmux set-option -pu -t "$TMUX_PANE" window-active-style 2>/dev/null
    ;;
esac
exit 0
