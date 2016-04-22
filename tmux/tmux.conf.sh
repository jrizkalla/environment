# Make open work
set-option -g default-command "reattach-to-user-namespace -l /usr/local/bin/zsh"
 
# Vim copy mode
set-window-option -g mode-keys vi
bind-key -t vi-copy 'v' begin-selection
bind-key -t vi-copy 'y' copy-selection

# Some useful mappings:
bind-key h select-pane -L
bind-key l select-pane -R
bind-key k select-pane -U
bind-key j select-pane -D

# Remap l because it does something useful
bind-key C-b last-window

# Bind pane splitting
bind-key - split-window v
bind-key | split-window h

# Enable mouse control
#set -g mouse-select-window on
#set -g mouse-select-pane on
#set -g mouse-resize-pane on
set -g mouse on


# Some color:
set -g status-fg white
set -g status-bg '#005f5f'
set -g status-right "#{prefix_highlight} CPU: #{cpu_percentage} Battery: #{battery_percentage} | %a %h-%d %H:%M"
set-window-option -g window-status-current-bg '#5fffff'
set-window-option -g window-status-current-fg black

# Set the clock to 12 hour not 24 hour
set-window-option -g clock-mode-style 12


# Plugins

# set -g @plugin "github_username/plugin_name"
set -g @plugin "tmux-plugins/tmux-yank"
set -g @plugin "tmux-plugins/tmux-cpu"
set -g @plugin "tmux-plugins/tmux-prefix-highlight"
set -g @plugin "tmux-plugins/tmux-battery"

# Initialize TMUX plugin manager
run "~/.tmux/plugins/tpm/tpm"