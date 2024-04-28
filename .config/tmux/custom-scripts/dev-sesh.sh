#!/bin/zsh

SESSIONNAME="dev"
WINDOW1="code"
tmux has-session -t $SESSIONNAME &> /dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESSIONNAME -n $WINDOW1 -c ~/dev
  tmux new-window -n server -t $SESSIONNAME:
fi;

tmux attach -t $SESSIONNAME\:code
