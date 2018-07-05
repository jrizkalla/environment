# Make open work
# Default command (fallback order):
#   reattach-to-username with zsh
#   reattach-to-username with bash
#   zsh
#   bash
#   sh
#set-option -g default-command 'reattach-to-user-namespace -l /usr/local/bin/zsh'
set-option -g default-command "tmux-default-command"
set-option -g focus-events on

# Vim copy mode
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi y send-keys -X copy-selection


# Some useful mappings:
bind-key h select-pane -L
bind-key l select-pane -R
bind-key k select-pane -U
bind-key j select-pane -D

bind-key C-b last-window

# Bind pane splitting
bind-key - split-window v
bind-key | split-window h

bind-key C-q confirm-before kill-session

# Enable mouse control
#set -g mouse-select-window on
#set -g mouse-select-pane on
#set -g mouse-resize-pane on
set -g mouse on

# Set TERM to screen-256color instead of just screen
set -g default-terminal "screen-256color"


# Some color:
set -g status-fg white
set -g status-bg '#005f5f'
set -g status-right "#{prefix_highlight} CPU: #{cpu_percentage} %a %h-%d %H:%M"
set-window-option -g window-status-current-bg '#5fffff'
set-window-option -g window-status-current-fg black

set -g pane-border-fg '#005f5f' # same color as Tmux's status line
set -g pane-active-border-fg '#008787' # same color as Vim's status line

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


# Useful shortcuts
 
bind-key a set-window-option synchronize-panes
