sesh='Home'

tmux new -s $sesh -d

tmux rename-window -t $sesh 'home'

tmux split-window -h
tmux select-pane -t 1
tmux resize-pane -R 22
tmux split-window -v

tmux select-pane -t 2
tmux resize-pane -D 15
tmux send-prefix -t home
tmux send-keys -t home C-b t

tmux attach -t $sesh
