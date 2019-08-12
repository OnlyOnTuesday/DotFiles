# user messages to printed at initialization of shell
#echo "TODO:"
echo "systemd.network 5"
echo "wifi hotspot for stuff"
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# show tty in use in PS1
PS1="[\u@\h:\l \W]\\$ "

# automatically switch to a directory when launched/restarted
#cd ~/C++/practice

# Allow user to restart bash shell after changes are
# made to this file
function restart(){
    clear
    . ~/.bashrc
} 

# Launch Tor browser from any directory using terminal
function tor(){
    dir=$(pwd)
    cd ~/tor-browser_en-US && ./start-tor-browser.desktop
    cd $dir
    echo "Tor started successfully"
}

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
#alias dnf="sudo dnf"
alias dat=/home/User1/.dat/releases/dat-13.12.2-linux-x64/dat
alias emacs="emacs -nw"
alias firefox="firefox &"
alias l="exa"
alias ls="exa -l"
#alias l="ls -C --color=auto"
#alias ls="ls -l --color=auto"
alias python="python3.7"
alias search="w3m"
alias TODO="cat ~/TODO"
alias i2p="~/i2p/i2prouter"
alias wireshark="/usr/local/bin/wireshark"

#modify PATH
export PATH="$PATH:/home/User1/.dat/releases/dat-13.12.2-linux-x64/dat"
export PYTHONPATH="$PYTHONPATH:/home/User1/.core_stable"
export PYTHONDONTWRITEBYTECODE=1

#modify env variables
unset SSH_ASKPASS
