#locale
export LC_ALL="en_US.UTF-8"
source "$HOME/.profile"

# neat aliases
if [ $(uname) = "Linux" ]; then
	alias ls="ls --color=always"
else
	alias ls="ls -G"
fi
alias ll="ls -l"
alias la="ls -a"
source ~/.zshalias

# completion
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
autoload -U compinit
compinit

# fasd
eval "$(fasd --init auto)"

# prompt
autoload -U colors && colors
PROMPT_HOST="%{${fg_bold[yellow]}%}%m "
PROMPT_CWD="%{${fg_bold[cyan]}%}%~ "
PROMPT_ARROW="%(?:%{$fg_bold[green]%}$ :%{$fg_bold[red]%}$ %s)"
PS1="$PROMPT_HOST$PROMPT_CWD$PROMPT_ARROW%{$reset_color%}"

export TERM="xterm"

# gem
PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin"
