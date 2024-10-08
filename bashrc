# shellcheck disable=SC1090,SC1091,SC2155
#============================================================================
#                                  Initial Setup
# ===========================================================================

# Exit if not running interactively
case "$-" in
    *i*) ;;
      *) return;;
esac

# ===========================================================================
#                              Environment Variables
# ===========================================================================

# Set USER if not already set
export USER="${USER:-$(whoami)}"
export GITUSER="${GITUSER:-USER}"

# Define directory paths
export REPOS="$HOME/repo"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/Dot"
export DOT="$DOTFILES"
export SCRIPTS="$DOTFILES/scripts"

# Terminal settings
export TERM="${TERM:-xterm-256color}"
export HRULEWIDTH=73

# Set default editor
export VISUAL=vi
export EDITOR="$VISUAL"
export EDITOR_PREFIX="$VISUAL"

# Go environment setup
if command -v go &>/dev/null; then
    export GOPATH="${GOPATH:-$HOME/.local/share/go}"
    export GOBIN="${GOBIN:-$HOME/.local/bin}"
    export PATH="$PATH:$GOBIN"
    export CGO_ENABLED=0
fi

# Less options and colors
export LESS="-FXR"
export LESS_TERMCAP_mb=$'\e[01;35m'    # Blink
export LESS_TERMCAP_md=$'\e[01;33m'    # Bold
export LESS_TERMCAP_me=$'\e[0m'        # Reset
export LESS_TERMCAP_se=$'\e[0m'        # Reset
export LESS_TERMCAP_so=$'\e[01;34m'    # Standout mode
export LESS_TERMCAP_ue=$'\e[0m'        # Reset
export LESS_TERMCAP_us=$'\e[01;04m'    # Underline

# ===========================================================================
#                                    Pager
# ===========================================================================

# Use lesspipe for advanced less functionality
if command -v lesspipe &>/dev/null; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

# ===========================================================================
#                                   History
# ===========================================================================

# History settings
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth 

# ============================================================================
#                                   Dircolors
# ============================================================================

# Set up dircolors if available
if command -v dircolors &>/dev/null; then
    if [[ -r "$HOME/.local/dircolors" ]]; then
        eval "$(dircolors -b "$HOME/.local/dircolors")"
    else
        eval "$(dircolors -b)"
    fi
fi

# ===========================================================================
#                                     PATH
# ===========================================================================

pathappend() {
  local arg
  for arg in "$@"; do
    test -d "$arg" || continue
    PATH=${PATH//":$arg:"/:}
    PATH=${PATH/#"$arg:"/}
    PATH=${PATH/%":$arg"/}
    PATH="${PATH:+"$PATH:"}$arg"
  done
}

pathprepend() {
  local arg
  for arg in "$@"; do
    test -d "$arg" || continue
    PATH=${PATH//":$arg:"/:}
    PATH=${PATH/#"$arg:"/}
    PATH=${PATH/%":$arg"/}
    PATH="$arg${PATH:+":$PATH"}"
  done
}

# Modify PATH
pathprepend \
  /usr/local/go/bin \
  "$HOME/.local/bin" \
  "$SCRIPTS"

pathappend \
  /usr/local/opt/coreutils/libexec/gnubin \
  /usr/share/bcc/tools \
  /usr/local/bin \
  /usr/local/sbin \
  /usr/local/games \
  /usr/games \
  /usr/sbin \
  /usr/bin \
  /snap/bin \
  /sbin \
  /bin

# Export PATH once after modifications
export PATH

# ============================================================================
#                                    CDPATH
# ============================================================================

# Directories for cd command to search
export CDPATH=".:$SCRIPTS:$DOT:$REPOS:/media/$USER:$HOME"

# ============================================================================
#                               Bash Shell Options
# ============================================================================

# Enable vi mode for command line editing
set -o vi

# Append to the history file, don't overwrite it
shopt -s histappend

# Check window size after each command and update LINES and COLUMNS
shopt -s checkwinsize

# Enable alias expansion
shopt -s expand_aliases

# Enable recursive globbing (e.g., **/*.txt)
shopt -s globstar

# Include dotfiles in filename expansion
shopt -s dotglob

# Enable extended pattern matching features
shopt -s extglob

# ============================================================================
#                                 Shell Prompt
# ============================================================================

# Prompt length settings
PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

# Function to construct the PS1 prompt
__ps1() {
    local P='$'
    local dir="${PWD##*/}"
    local B countme short long double
    local r='\[\e[31m\]'    # Red
    local g='\[\e[30m\]'    # Black
    local h='\[\e[34m\]'    # Blue
    local u='\[\e[33m\]'    # Yellow
    local p='\[\e[34m\]'    # Blue
    local w='\[\e[35m\]'    # Magenta
    local b='\[\e[36m\]'    # Cyan
    local x='\[\e[0m\]'     # Reset

    # Adjust prompt for root user
    if [[ "$EUID" == 0 ]]; then
        P='#'
        u=$r
        p=$u
    fi

    # Adjust directory display
    [[ "$PWD" == "/" ]] && dir="/"
    [[ "$PWD" == "$HOME" ]] && dir='~'

    # Get current Git branch
    B=$(git branch --show-current 2>/dev/null)
    [[ "$dir" == "$B" ]] && B='.'
    countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

    # Highlight master or main branch
    if [[ "$B" == "master" || "$B" == "main" ]]; then
        b="$r"
    fi

    [[ -n "$B" ]] && B="$g($b$B$g)"

    # Construct prompt variations
    short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
    long="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n$g╚ $p$P$x "
    double="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir\n$g║ $B\n$g╚ $p$P$x "

    # Select prompt based on length
    if (( ${#countme} > PROMPT_MAX )); then
        PS1="$double"
    elif (( ${#countme} > PROMPT_LONG )); then
        PS1="$long"
    else
        PS1="$short"
    fi
}

# Set PROMPT_COMMAND to invoke __ps1 before each command
PROMPT_COMMAND="__ps1"

# ============================================================================
#                                    Aliases
# ============================================================================

# Custom aliases
alias coin="clip '(yes|no)'"
alias ls='ls -h --color=auto'
alias scripts='cd "$SCRIPTS"'
alias c='printf "\e[H\e[2J"'             
alias grep='grep -i --color=auto'
alias fgrep='fgrep -i --color=auto'
alias diff='diff --color'
alias tree='tree -a -C'
alias temp='cd "$(mktemp -d)"'
alias vi=vim

# ============================================================================
#                                   Functions
# ============================================================================

# Check if a command exists
_have() { type "$1" &>/dev/null; }

# ============================================================================
#                                  Completions
# ============================================================================

owncomp=(kind pandoc helm kubectl yq gh ./setup)

for i in "${owncomp[@]}"; do complete -C "$i" "$i"; done

_have kubectl && . <(kubectl completion bash)
_have gh && . <(gh completion -s bash)
_have kind && . <(kind completion bash)
_have pandoc && . <(pandoc --bash-completion)
_have yq && . <(yq shell-completion bash)
_have helm && . <(helm completion bash)

complete -C '/usr/local/bin/aws_completer' aws
complete -C '/usr/bin/terraform' terraform
