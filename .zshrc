# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# ZSH OPTIONS
ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy/mm/dd"
setopt NO_BEEP

# OH MY ZSH INITIALISATION
ZSH_THEME="shift"
export ZSH=~/.oh-my-zsh
plugins=(sudo command-not-found zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
zmodload zsh/datetime

alias ussh="ssh z5161933@login.cse.unsw.edu.au -t 'exec'"
zssh () { ssh "$@" -t 'exec'; }

# LS AND CD COLORING
alias ls='ls --group-directories-first --color=auto' 
eval `dircolors ~/.dircolors`
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}" 
autoload -Uz compinit 
compinit
