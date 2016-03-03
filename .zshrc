# locale
export LC_ALL="en_US.UTF-8"
source "$HOME/.profile"

# make zsh behave

#Rebind HOME and END to do the decent thing:
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
case $TERM in (xterm*)
bindkey '\eOH' beginning-of-line
bindkey '\eOF' end-of-line
esac
#And DEL too, as well as PGDN and insert:
bindkey '\e[3~' delete-char
bindkey '\e[6~' end-of-history
bindkey '\e[2~' redisplay
#Now bind pgup to paste the last word of the last command,
bindkey '\e[5~' insert-last-word

# neat aliases
if [ $(uname) = "Linux" ]; then
	alias ls="ls --color=always"
else
	alias ls="ls -G"
fi
alias ll="ls -l"
alias la="ls -a"
source ~/.shrc

# completion
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
autoload -U compinit
compinit

# prompt
autoload -U colors && colors
PROMPT_HOST="%{${fg_bold[yellow]}%}%m "
PROMPT_CWD="%{${fg_bold[cyan]}%}%~ "
PROMPT_ARROW="%(?:%{$fg_bold[green]%}$ :%{$fg_bold[red]%}$ %s)"
PS1="$PROMPT_HOST$PROMPT_CWD$PROMPT_ARROW%{$reset_color%}"

# gem
PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin"
