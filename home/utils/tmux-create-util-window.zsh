#!/bin/zsh

window_name=utils

tmux new-window -n $window_name
tmux split-window -h
tmux split-window -v
