# dotfiles

Dotfiles for all my machines.

## Setup (taken and adapted from [Hacker News](https://news.ycombinator.com/item?id=11070797))

1. Initialize a bare git repository
	
	```
	git init --bare $HOME/.myconf
	```

2. Setup alias to differentiate between `git` command

	```
	alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
	```

	Note: this can be added to something like `~/.bashrc` or `~/.zshrc`

3. Remove untracked files from being shown when running `config status`

	```
	config config status.showUntrackedFiles no
	```

## Usage

The `~/.myconf` directory is a git bare repository, so any file within the home folder can be versioned with normal commands like:

```
config status
config add .vimrc
config commit -m "Add vimrc"
config add .config/redshift.conf
config commit -m "Add redshift config"
config push
```

With this, there is no extra tooling, no symlinks, files are tracked on a version control system, you can use different branches for different computers, and you can replicate you configuration easily on new installation.
