#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# .bashrc
alias editrc='vim ~/.bashrc'
alias sourcerc='source ~/.bashrc'
alias lessrc='less ~/.bashrc'


# bash history
export HISTFILE="$HOME/.bash_history"
export HISTSIZE=1000000
export HISTFILESIZE=2000000
export HISTTIMEFORMAT='%F %T  '
shopt -s histappend
PROMPT_COMMAND='history -a; history -c; history -r;'


# general aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias ff='fastfetch'
alias fm='nohup thunar . >/dev/null 2>&1 & disown'
alias memo='vim ~/memo.txt'

alias dow='cd ~/Downloads'
alias sc='cd ~/Pictures/Screenshots'

alias google-laptop='nohup google-chrome-stable --force-device-scale-factor=2 >/dev/null 2>&1 & disown'
alias google-docked='nohup google-chrome-stable --force-device-scale-factor=1 >/dev/null 2>&1 & disown'


# config
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias i3config='vim ~/.config/i3/config'


# PATH
export PATH="$HOME/bin:$PATH"
