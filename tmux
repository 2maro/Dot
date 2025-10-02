# ==============================================================================
#                               Terminal and Color Settings
# ==============================================================================

# Set the default terminal to support 256 colors and truecolor
set -g default-terminal "tmux-256color"

# Enable true color (24-bit) support - this is crucial for your vim colors
set-option -sa terminal-overrides ',xterm-256color:RGB'
#set-option -sa terminal-overrides ',xterm-256color:Tc'
set -ga terminal-overrides ",*256col*:Tc"
set-option -sa terminal-overrides ',xterm-256color:RGB'

# Additional terminal features for modern terminals
#set-option -sa terminal-features ',xterm-256color:RGB'

# Enable italics support (you already have this working)
set-option -sa terminal-overrides ',xterm*:sitm=\E[3m,ritm=\E[23m'
set -as terminal-features ",xterm-256color:italics"

# ==============================================================================
#                               Prefix and Key Bindings
# ==============================================================================

# Set Ctrl+a as the prefix key (like GNU Screen)
unbind C-b
unbind C-a
set -g prefix C-a

# Use Ctrl+y to send prefix in nested tmux sessions
bind-key -n C-y send-prefix

# Quick toggle to last window with double-tap of prefix
bind-key C-a last-window

# Reload tmux configuration
bind r source-file ~/.tmux.conf \; display-message "Tmux config reloaded"

# Split pane shortcuts (similar to modern screen)
unbind |
unbind '\'
bind | split-window -h
bind '\' split-window -h
bind 'C-\' split-window -h

unbind '_'
bind - split-window -v
bind '_' split-window -v

# Pane navigation using Vim keys
bind -r h select-pane -L
bind -r j select-pane -D
bind -r k select-pane -U
bind -r l select-pane -R

# Pane resizing using Ctrl + Vim keys
bind -r C-h resize-pane -L 1
bind -r C-j resize-pane -D 1
bind -r C-k resize-pane -U 1
bind -r C-l resize-pane -R 1

# ==============================================================================
#                               Copy Mode and Keys
# ==============================================================================

# Use vi keys in copy mode
setw -g mode-keys vi

# Use vi keys in the status line
set -g status-keys vi

# Set focus events for terminal applications
set -g focus-events off

# Set Mouse off on tmux
set -g mouse off

# ==============================================================================
#                                  Appearance
# ==============================================================================

# Set pane border colors
set -g pane-border-style fg=#171717
set -g pane-active-border-style fg=#171717

# Status bar style
set -g status-style fg=#665c54,bg=default
set -g status-interval 5
set -g status-left ''
set -g status-right "#[fg=gold]%b/%d/%y %I:%M%p"

# Message style
set -g message-style fg=red

# Set clock mode color
setw -g clock-mode-colour cyan

# Disable automatic window renaming
set -g automatic-rename off

# Base index for windows and panes starts at 1
set -g base-index 1
setw -g pane-base-index 1

# ==============================================================================
#                               Performance Tweaks
# ==============================================================================

# Reduce delay when entering copy mode or switching panes
set -s escape-time 10

# Adjust repeat time for key bindings
set -g repeat-time 100

# ==============================================================================
#                                  Miscellaneous
# ==============================================================================

# Set history file
set -g history-file ~/.tmux_history

