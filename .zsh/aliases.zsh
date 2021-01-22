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

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ds='config status'

alias pubip='curl icanhazip.com'
alias localip='ifconfig | grep -Eo "inet (addr:)?([0-9]*\.){3}[0-9]*" | grep -Eo "([0-9]*\.){3}[0-9]*" | grep -v "127.0.0.1"'
