sesh='Home'

tmux new -s $sesh -d

tmux rename-window -t $sesh 'home'

tmux split-window -h "tail -f ~/.log_file"
tmux select-pane -t 1
tmux resize-pane -R 40

tmux select-pane -t 0

tmux attach -t $sesh
