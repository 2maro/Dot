case $- in
    *i*) ;;
      *) return;;
esac

#evnioment variables

export SCRIPTS="$HOME/.local/SCRIPTS"
export TERM=xterm-256color
export HRULEWIDTH=73
export EDITOR=vi
export VISUAL=vi
export EDITOR_PREFIX=vi

export LESS_TERMCAP_mb="^[[35m"
export LESS_TERMCAP_md="^[[33m"
export LESS_TERMCAP_me="^[0"
export LESS_TERMCAP_se="^[0"
export LESS_TERMCAP_so="^[[34m"
export LESS_TERMCAP_ue="^[0"
export LESS_TERMCAP_us="^[[4m"
# ------------------------------- pager ------------------------------

if [[ -x /usr/bin/lesspipe ]]; then
  export LESSOPEN="| /usr/bin/lesspipe %s";
  export LESSCLOSE="/usr/bin/lesspipe %s %s";
fi
# ------------------------------ history -----------------------------

set -o vi
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth

# ----------------------------- dircolors ----------------------------

if [ -x /usr/bin/dircolors ]; then
  if [[ -r "$HOME//local/dircolors" ]]; then
    eval "$(dircolors -b "$HOME/.local/dircolors")"
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
  /mingw64/bin \
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
shopt -s histappend
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
#---------------------------shell promt-------------------------------

export PS1='\[\e[33m\]\u\[\e[39m\]@\[\e[34m\]\W\[\e[33m\]$\[\e[0m\] '

# ------------------------------ aliases -----------------------------

alias coin="clip '(yes|no)'"
alias ls='ls -h --color=auto'
alias scripts='cd $SCRIPTS'
alias c='printf "\e[H\e[2J"'

# ----------------------------- functions ----------------------------



# ------------- source external dependencies / completion ------------

owncomp=(greet)

for i in ${owncomp[@]}; do complete -C $i $i; done
