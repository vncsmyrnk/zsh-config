#!/bin/zsh

# Creates a new window in tmux with
# 3 panes

window_name=utils

tmux new-window -n $window_name
tmux split-window -h
tmux split-window -v
