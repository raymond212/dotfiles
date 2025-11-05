#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enviroment variables
export PATH="$HOME/bin:$PATH"
export EDITOR="nvim"

# Shell settings
PS1='[\u@\h \W]\$ '

# Configurations
alias editrc='$EDITOR ~/.bashrc'
alias sourcerc='source ~/.bashrc'

alias i3conf='$EDITOR ~/.config/i3/config'
alias nvimconf='$EDITOR ~/.config/nvim/init.lua'

# Bash history
export HISTFILE="$HOME/.bash_history"
export HISTSIZE=1000000
export HISTFILESIZE=2000000
export HISTTIMEFORMAT='%F %T  '
shopt -s histappend
PROMPT_COMMAND='history -a; history -c; history -r;'

# Git
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias folio='git --git-dir=$HOME/.folio.git --work-tree=$HOME'

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias ff='fastfetch'
alias fm='nohup thunar . >/dev/null 2>&1 & disown'

alias doc='cd ~/Documents'
alias dow='cd ~/Downloads'
alias sc='cd ~/Pictures/Screenshots'
alias memo='$EDITOR ~/memo.txt'

alias google-laptop='nohup google-chrome-stable --force-device-scale-factor=2 >/dev/null 2>&1 & disown'
alias google-docked='nohup google-chrome-stable --force-device-scale-factor=1 >/dev/null 2>&1 & disown'
