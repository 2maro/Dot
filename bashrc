# shellcheck disable=SC1090,SC1091,SC2155

# Exit if not running interactively
case "$-" in
    *i*) ;;
    *) return;;
esac

# ---------------------- local utility functions ---------------------

_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }

# ----------------------- environment variables ----------------------

export LANG=en_US.UTF-8
export USER="${USER:-$(whoami)}"
export GITUSER="$USER"
export TZ=America/Chicago

export REPOS="$HOME/Repos"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/Dot"
export DOT="$DOTFILES"
export SCRIPTS="$DOTFILES/scripts"

export VISUAL=vim
export EDITOR="$VISUAL"
export EDITOR_PREFIX="$VISUAL"
export KUBE_EDITOR="$VISUAL"

export HISTSIZE=10000
export HISTFILESIZE=20000

export LESS="-FXR -RAW-CONTROL-CHARS"
export TERM="${TERM:-xterm-256color}"
export COLORTERM="truecolor"
export LESS_TERMCAP_md=$'\e[1;33m'
export LESS_TERMCAP_mb=$'\e[1;35m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[38;5;108;1m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4m'
export LESS_TERMCAP_ue=$'\e[0m'

# Go support
if command -v go &>/dev/null; then
    export GOPATH="$HOME/.local/share/go"
    export GOBIN="$HOME/.local/bin"
    export PATH="$PATH:$GOBIN"
    export CGO_ENABLED=0
fi

# ----------------------------- aliases ----------------------------

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
alias nvi=nvim

# ----------------------------- dircolors ----------------------------

if _have dircolors; then
    if [[ -r "$HOME/.local/dircolors" ]]; then
        eval "$(dircolors -b \"$HOME/.local/dircolors\")"
    else
        eval "$(dircolors -b)"
    fi
fi

# ------------------------------- path -------------------------------

pathappend() {
    declare arg
    for arg in "$@"; do
        test -d "$arg" || continue
        PATH=${PATH//":$arg:"/:}
        PATH=${PATH/#"$arg:"/}
        PATH=${PATH/%":$arg"/}
        export PATH="${PATH:+"$PATH:"}$arg"
    done
} && export -f pathappend

pathprepend() {
    for arg in "$@"; do
        test -d "$arg" || continue
        PATH=${PATH//":$arg:"/:}
        PATH=${PATH/#"$arg:"/}
        PATH=${PATH/%":$arg"/}
        export PATH="$arg${PATH:+":$PATH"}"
    done
} && export -f pathprepend

pathprepend \
    "$HOME/.cargo/bin" \
    "/usr/local/go/bin" \
    "$HOME/.local/bin" \
    "$SCRIPTS" \
    "/opt/homebrew/bin"

pathappend \
    "/usr/local/opt/coreutils/libexec/gnubin" \
    "/usr/local/bin" "/usr/bin" "/bin" \
    "/usr/sbin" "/sbin" \
    "/usr/local/sbin"

# ------------------------------ cdpath ------------------------------

export CDPATH=".:$SCRIPTS:$DOT:$REPOS:$HOME"

# ------------------------ bash shell options ------------------------

set -o vi
shopt -s histappend
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
stty -ixon

# --------------------------- smart prompt ---------------------------

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT="@"
__ps1() {
    local dir B countme short long double P
    local r h u p w b x g  # color codes

    r='\[\033[38;2;255;85;85m\]'      # Bright red (root/error)
    h='\[\033[38;2;131;165;152m\]'    # Dusty aqua blue (hostname) 
    u='\[\033[38;2;184;187;38m\]'     # Bright lime green (username - like "nox")
    p='\[\033[38;2;131;165;152m\]'    # Dusty aqua (prompt symbol)
    w='\[\033[38;2;215;153;33m\]'     # Orange/amber (working directory)
    b='\[\033[38;2;131;165;152m\]'    # Dusty aqua (git branch)
    x='\[\e[0m\]'                     # Reset
    g='\[\033[38;2;204;204;204m\]'    # Light gray (decorations like @, :, etc)

    [[ $EUID == 0 ]] && P='#' && u=$r && p=$u
    [[ $PWD = / ]] && dir=/
    [[ $PWD = "$HOME" ]] && dir='~'

    dir="${PWD##*/}"
    B=$(git branch --show-current 2>/dev/null)
    [[ $dir = "$B" ]] && B=.
    countme="$USER$PROMPT_AT$(hostname):${dir}[$B]\$ "

    [[ $B == master || $B == main ]] && b="$r"
    [[ -n "$B" ]] && B="$g($b$B$g)"

    short="$u\\u$g$PROMPT_AT$h\\h$g:$w$dir$B$p$P$x "
    long="${g}╔$u\\u$g$PROMPT_AT$h\\h$g:$w$dir$B\n${g}╚$p$P$x "
    double="${g}╔$u\\u$g$PROMPT_AT$h\\h$g:$w$dir\n${g}║$B\n${g}╚$p$P$x "

    if (( ${#countme} > PROMPT_MAX )); then
        PS1="$double"
    elif (( ${#countme} > PROMPT_LONG )); then
        PS1="$long"
    else
        PS1="$short"
    fi

}

PROMPT_COMMAND="__ps1"

# ------------------------ os awareness ------------------------------

if [[ "$OSTYPE" == "darwin"* ]]; then
    brew_prefix="$(brew --prefix)"
    if [[ -r "$brew_prefix/etc/profile.d/bash_completion.sh" ]]; then
        source "$brew_prefix/etc/profile.d/bash_completion.sh"
    fi
    export BROWSER=open
fi

# --------------------------- completions ----------------------------

owncomp=(kind helm kubectl yq gh ./setup flux)
for i in "${owncomp[@]}"; do complete -C "$i" "$i"; done

_have kubectl && . <(kubectl completion bash)
_have gh && . <(gh completion -s bash)
_have kind && . <(kind completion bash)
_have yq && . <(yq shell-completion bash)
_have helm && . <(helm completion bash)
_have flux && . <(flux completion bash)

complete -C '/usr/local/bin/aws_completer' aws
complete -C '/usr/bin/terraform' terraform
complete -C '/usr/bin/cargo' cargo
complete -C '/usr/bin/rustup' rustup
complete -C '/usr/bin/rustc' rustc
. "$HOME/.cargo/env"
