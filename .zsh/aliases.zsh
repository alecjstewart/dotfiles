alias ls='ls -G'
alias ll='ls -la'
alias l.='ls -Gd .*'
alias v='nvim'

alias cpu='top -o cpu'
alias grep='grep --color'
alias pubip="curl icanhazip.com"
alias lsd='ls -lah | grep "^d"'
alias mem='top -o rsize' # memory
alias please='sudo $(fc -ln -1)' # or sudo $(history -p !!) for bash

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
