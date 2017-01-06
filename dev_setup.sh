#!/bin/bash

# setup bottom pane
tmux split-window -v -p 25 "python"
tmux select-pane -t 0

# setup right pane
tmux split-window -h -p 25
tmux select-pane -t 0
