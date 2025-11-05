#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias editrc='vim ~/.bashrc'
alias sourcerc='source ~/.bashrc'
alias catrc='cat ~/.bashrc | less'

alias ff='fastfetch'

alias google-laptop='nohup google-chrome-stable --force-device-scale-factor=2 >/dev/null 2>&1 & disown'
alias google-docked='nohup google-chrome-stable --force-device-scale-factor=1 >/dev/null 2>&1 & disown'

alias memo='vim ~/memo.txt'

alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias i3config='vim ~/.config/i3/config'

export PATH="$HOME/bin:$PATH"
