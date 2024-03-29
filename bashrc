case $- in
    *i*) ;;
      *) return;;
esac

# ------------------------------- env variables ------------------------------

export USER="$(whoami)"
export GITUSER="$USER"
export REPOS="$HOME/repo"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/Dot"
export SCRIPTS="$HOME/repo/github.com/2maro/Dot/scripts"
export TERM=xterm-256color
export HRULEWIDTH=73
export CGO_ENABLED=0
export VISUAL=vi
export EDITOR=vi
export EDITOR_PREFIX=vi
export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/bin"
export PATH="$PATH:/usr/local/protobuf/bin"
export LESS="-FXR"
export LESS_TERMCAP_mb=$(printf '\e[01;35m')
export LESS_TERMCAP_md=$(printf '\e[01;33m')
export LESS_TERMCAP_me=$(printf '\e[0m') 
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_so=$(printf '\e[01;34m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_us=$(printf '\e[01;4m')

# ------------------------------- pager ------------------------------

if [[ -x /usr/bin/lesspipe ]]; then
  export LESSOPEN="| /usr/bin/lesspipe %s";
  export LESSCLOSE="/usr/bin/lesspipe %s %s";
fi

# ------------------------------ history -----------------------------

HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth

# ----------------------------- dircolors ----------------------------

if [ -x /usr/bin/dircolors ]; then
  if [[ -r "$HOME//local/dircolors" ]]; then
    eval "$(dircolors -b "$HOME/dircolors")"
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
} && export pathappend

pathprepend() {
  for arg in "$@"; do
    test -d "$arg" || continue
    PATH=${PATH//:"$arg:"/:}
    PATH=${PATH/#"$arg:"/}
   PATH=${PATH/%":$arg"/}
    export PATH="$arg${PATH:+":${PATH}"}"
  done
} && export pathprepend

#remember last arg will be first in path

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
# ------------------------------ cdpath ------------------------------

export CDPATH=".:$SCRIPTS:$DOT:$REPOS:/media/$USER:$HOME"

# ------------------------ bash shell options ------------------------

set -o vi
shopt -s histappend
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob

#---------------------------shell promt-------------------------------

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
  local P='$' dir="${PWD##*/}" B countme short long double\
    r='\[\e[31m\]' g='\[\e[30m\]' h='\[\e[34m\]' \
    u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
    b='\[\e[36m\]' x='\[\e[0m\]'

  [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'

  B=$(git branch --show-current 2>/dev/null)
  [[ $dir = "$B" ]] && B=.
  countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

  [[ $B = master || $B = main ]] && b="$r"
  [[ -n "$B" ]] && B="$g[$b$B$g]"

  short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
  long="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n$g╚ $p$P$x "
  double="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir\n$g║ $B\n$g╚ $p$P$x "

  if (( ${#countme} > PROMPT_MAX )); then
    PS1="$double"
  elif (( ${#countme} > PROMPT_LONG )); then
    PS1="$long"
  else
    PS1="$short"
  fi
}

PROMPT_COMMAND="__ps1"

# ------------------------------ aliases -----------------------------

alias coin="clip '(yes|no)'"
alias ls='ls -h --color=auto'
alias scripts='cd $SCRIPTS'
alias c='printf "\e[H\e[2J"'
alias grep='grep -i --colour=auto'
alias grep='fgrep -i --colour=auto'
alias diff='diff --color'
alias tree='tree -a'
alias temp='cd $(mktemp -d)'
alias vi=vim
# ----------------------------- functions ----------------------------

_have() { type "$1" &>/dev/null; }

# ------------- source external dependencies / completion ------------

owncomp=(kind pandoc helm kubectl yq gh ./setup)

for i in ${owncomp[@]}; do complete -C $i $i; done

_have kubectl && . <(kubectl completion bash)
_have gh && . <(gh completion -s bash)
_have kind && . <(kind completion bash)
_have pandoc && . <(pandoc --bash-completion)
_have yq && . <(yq shell-completion bash)
_have helm && . <(helm completion bash)

complete -C '/usr/local/bin/aws_completer' aws
complete -C '/$HOME/.local/bin/terraform' terraform
