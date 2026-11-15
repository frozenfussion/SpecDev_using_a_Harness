#!/usr/bin/env bash
# tmux-work.sh: one window, four titled tiles.
set -euo pipefail
S=work

if tmux has-session -t "$S" 2>/dev/null; then
  exec tmux attach -t "$S"
fi

tmux new-session -d -s "$S" -n work          # tile 0
tmux split-window -h -t "$S":work            # tile 1, to the right
tmux split-window -v -t "$S":work.0          # a tile under tile 0
tmux split-window -v -t "$S":work.2          # a tile under the right one
tmux select-layout -t "$S":work tiled        # four equal tiles

# Titles on the borders, and mouse support.
tmux set-option -t "$S" pane-border-status top
tmux set-option -t "$S" pane-border-format " #{pane_index}: #{pane_title} "
tmux set-option -t "$S" mouse on
tmux set-option -t "$S" history-limit 50000
# Stop programs from renaming the tiles.
tmux set-option -w -t "$S":work allow-rename off

tmux select-pane -t "$S":work.0 -T "BUILDER A"
tmux select-pane -t "$S":work.1 -T "BUILDER B"
tmux select-pane -t "$S":work.2 -T "REVIEWER"
tmux select-pane -t "$S":work.3 -T "SHELL (owner)"

tmux select-pane -t "$S":work.3
exec tmux attach -t "$S"
