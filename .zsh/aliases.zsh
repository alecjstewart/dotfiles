alias ls='ls -G'
alias ll='ls -la'
alias l.='ls -Gd .*'

alias v='nvim'
alias cpu='top -o cpu'
alias grep='grep --color'
alias lsd='ls -lah | grep "^d"'
alias mem='top -o rsize' # memory
alias please='sudo $(fc -ln -1)' # or sudo $(history -p !!) for bash

alias gcm='git commit -m'
alias gpu='git push'
alias gpl='git pull'
alias gs='git status'
alias gaa='git add .'

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cs='config status'

alias pubip='curl icanhazip.com'
alias localip='ifconfig | grep -Eo "inet (addr:)?([0-9]*\.){3}[0-9]*" | grep -Eo "([0-9]*\.){3}[0-9]*" | grep -v "127.0.0.1"'

note() {
	date=$(date +'%Y%m%d%H%M')
	args=$@
	dashargs=${args// /-}
	filename=$date-$dashargs.md

	echo "# $date $args" >> $filename
	echo "" >> $filename
	echo "" >> $filename
	echo "" >> $filename
	echo "## links" >> $filename
	
	nvim $filename
}
