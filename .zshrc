# Configuration adapted from Josh Dick at <https://github.com/joshdick/dotfiles/blob/master/zshrc.symlink>

###
# ZSH-SPECIFIC SETTINGS
###

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt autocd beep nomatch prompt_subst correct inc_append_history interactivecomments share_history
unsetopt notify
bindkey -v
zstyle :compinstall filename '$HOME/.zshrc'

# Autocomplete from the middle of a filename
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# Colors
autoload -Uz compinit && compinit
autoload -U colors && colors
eval $(dircolors ~/.dircolors)

# PATH
#export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
#export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH=~/.npm-global/bin:$PATH
export GPG_TTY=$(tty)

# Misc
/usr/bin/keychain $HOME/.ssh/github
source $HOME/.keychain/$HOST-sh
source $HOME/.env

precmd() {
	echo -ne "\e]1;$USER@$(hostname): $(dirs)\a"
}

###
# ALIASES
###

source ~/.zsh/aliases.zsh

###
# ZSH PLUGINS
###

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Bind up and down keys for zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

###
# PROMPT SETTINGS
###

export VIRTUAL_ENV_DISABLE_PROMPT=1
virtualenv_info() {
    if test -z "$VIRTUAL_ENV" ; then
        echo ""
    else
        echo " via %{$fg_bold[green]%}`basename $VIRTUAL_ENV`%{$reset_color%}"
    fi
}

# Echoes information about Git repository status when inside a Git repository
git_info() {

    # Exit if not inside a Git repository
    ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

    # Git branch/tag, or name-rev if on detached head
    local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

    local AHEAD="%{$fg_bold[red]%}⇡NUM%{$reset_color%}"
    local BEHIND="%{$fg_bold[cyan]%}⇣NUM%{$reset_color%}"
    local MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
    local UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"
    local MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"
    local STAGED="%{$fg_bold[green]%}●%{$reset_color%}"

    local -a DIVERGENCES
    local -a FLAGS

    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
        DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
    fi

    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
        DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
    fi

    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
        FLAGS+=( "$MERGING" )
    fi

    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        FLAGS+=( "$UNTRACKED" )
    fi

    if ! git diff --quiet 2> /dev/null; then
        FLAGS+=( "$MODIFIED" )
    fi

    if ! git diff --cached --quiet 2> /dev/null; then
        FLAGS+=( "$STAGED" )
    fi

    local -a GIT_INFO
    GIT_INFO+=( " on %{$fg_bold[magenta]%}$GIT_LOCATION%{$reset_color%}" )
    [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
    [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
    echo "${(j: :)GIT_INFO}"

}

# Use $ as the non-root prompt character; # for root
# Change the prompt character color if the last command had a nonzero exit code
PS1='
%{$fg_bold[yellow]%}%n%{$reset_color%} at %{$fg_bold[yellow]%}$(hostname -f)%{$reset_color%} in %{$fg_bold[blue]%}%~%{$reset_color%}$(git_info)$(virtualenv_info)
%(?.%{$fg[cyan]%}.%{$fg[red]%})%(!.#.$)%{$reset_color%} '
