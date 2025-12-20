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
alias dotexclude='$EDITOR ~/.dotfiles.git/info/exclude'
alias folio='git --git-dir=$HOME/.folio.git --work-tree=$HOME'

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias ff='fastfetch'
alias fm='nohup thunar . >/dev/null 2>&1 & disown'

alias doc='cd ~/Documents'
alias dow='cd ~/Downloads'
alias pics='cd ~/Pictures'
alias sc='cd ~/Pictures/screenshots'
alias memo='$EDITOR ~/memo.txt'
alias journal='$EDITOR ~/Documents/journal.md'

alias nvid='nvidia-smi && nvidia-smi | tr -s " " | grep -Eo "| [0-9]+ N/A N/A [0-9]{3,} .*" | awk -F" " '\''{pid=$4; gpu_mem=$7; cmd="cat /proc/"pid"/cmdline | tr \"\\0\" \" \""; cmdline=""; while((cmd|getline cl)>0){cmdline=(cmdline cl)} close(cmd); usercmd="ps -o uname= -p "pid; u=""; while((usercmd|getline uu)>0){u=uu} close(usercmd); timecmd="ps -o etime= -p "pid; et=""; while((timecmd|getline tt)>0){et=tt} close(timecmd); gsub(/^ +| +$/, "", et); if(et ~ /-/){split(et,a,"-"); et=a[1]"d "a[2]} printf "%s\t%s\t%s\t%s\t%s\t%s\n", $1, pid, u, et, gpu_mem, cmdline}'\'''


alias google-laptop='nohup google-chrome-stable --force-device-scale-factor=2 >/dev/null 2>&1 & disown'
alias google-docked='nohup google-chrome-stable --force-device-scale-factor=1 >/dev/null 2>&1 & disown'

alias sinks='pactl list short sinks | awk '\''{ printf "%-10s %s\n", $7, $2 }'\'''
alias bt-airpods='bluetoothctl connect 2C:32:6A:D9:12:B0'
alias bt-airpods-dc='bluetoothctl disconnect 2C:32:6A:D9:12:B0'
alias bt-beats='bluetoothctl connect 78:4F:43:D0:FA:F8'
alias bt-beats-dc='bluetoothctl disconnect 78:4F:43:D0:FA:F8'

alias im-on='fcitx5 &'
alias im-off='pkill fcitx5'

# Functions
foliosync() {
  folio switch -q staging
  folio add -u
  folio commit -m "update: $(date +'%F %H:%M')"
  folio push
}

sink-int() {
  sink="alsa_output.pci-0000_00_1f.3.analog-stereo"
  pactl set-default-sink "$sink"
  echo "Default sink set to: $sink"
}

sink-bt() {
  sink=$(pactl list short sinks | awk '$2 ~ /^bluez_output\./ { print $2; exit }')
  [ -z "$sink" ] && { echo "No Bluetooth sink found"; return 1; }
  pactl set-default-sink "$sink"
  echo "Default sink set to: $sink"
}
