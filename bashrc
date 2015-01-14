# Bash defaults

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Stupid proof destructive commands
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"


# Add some color
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
