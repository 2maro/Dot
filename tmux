

# change default meta key to same as screen
unbind C-b
unbind C-a
set -g prefix C-a
#time
set -sg esacpe-time 0
# form vim/tmux d/y buffer sync
set -g focus-events

# use a different prefix for nested
bind-key -n C-y send-prefix

# add double-tap meta key to toggle last window
bind-key C-a last-window


# create more intuitive split key combos (same as modern screen)
unbind |
bind | split-window -h
bind '\' split-window -h
bind 'C-\' split-window -h

unbind -
bind - split-window -v
bind '-' split-window -v
bind '_' split-window -v

# vi for copy mode
setw -g mode-keys vi

# vi for command status
set -g status-keys vi

# vi keys to resize
bind -r C-k resize-pane -U 1
bind -r C-j resize-pane -D 1
bind -r C-h resize-pane -L 1
bind -r C-l resize-pane -R 1

# vi keys to navigate panes
bind -r k select-pane -U
bind -r j select-pane -D
bind -r h select-pane -L
bind -r l select-pane -R

# avoid cursor movement messing with resize
set -g repeat-time 200
set -s escape-time 0

#reload configuration
bind -r r source-file ~/.tmux.conf
set -g message-style "fg=red"

#colors
set -g default-terminal "screen-256color"

#set -g clock-mode-style 12
setw -g clock-mode-colour cyan
set -g base-index 1
setw -g pane-base-index 1
