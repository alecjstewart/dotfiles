# dotfiles

Dotfiles for all my machines. Includes a `windows` branch for Windows dotfiles, a `macos` branch for macOS dotfiles, and a `linux` branch for Linux dotfiles.

## Setup

1. Initialize a bare git repository
	
	```
	git init --bare $HOME/.cfg
	```

2. Setup alias to differentiate between `git` command

	```
	alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
	```

	Note: this can be added to something like `~/.bashrc` or `~/.zshrc`

3. Remove untracked files from being shown when running `dotfiles status`

	```
	dotfiles config status.showUntrackedFiles no
	```

## Usage[1]

The `~/.cfg` directory is a git bare repository, so any file within the home folder can be versioned with normal commands like:

```
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles add .config/redshift.conf
dotfiles commit -m "Add redshift config"
dotfiles push
```

With this, there is no extra tooling, no symlinks, files are tracked on a version control system, you can use different branches for different computers, and you can replicate you configuration easily on new installation.

## Cloning[2]

If you want to clone this repository for use on a new a machine...

1. Setup your dotfile alias

	macOS/Linux:
	```
	alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME
	```

	Windows (add this to your Powershell profile):
	```
	function Dotfile-Config {
		git --git-dir=$HOME\.cfg\ --work-tree=$HOME $args
	}
	Set-Alias -Name dotfiles -Value Dotfile-Config
	```

2. To avoid recursion problems, add your source `.cfg` folder to your `.gitignore`

	```
	echo ".cfg" >> .gitignore
	```

3. Clone your dotfiles into a bare repository in a "dot" folder of your `$HOME`

	```
	git clone --bare <git-repo-url> $HOME/.cfg
	```

	or if you want to clone from a specific branch

	```
	git clone --bare -b <branch-name> <git-repo-url> $HOME/.cfg
	```

4. Checkout the content from the bare repository to your `$HOME`

	```
	dotfiles checkout
	```

	If the above fails with a message like:

	```
	error: The following untracked working tree files would be overwritten by checkout:
		.bashrc
		.gitignore
	Please move or remove them before you can switch branches.
	Aborting
	```

	This is because your `$HOME` folder already has some stock configuration files which would be overwritten by Git. The solution is simple: back up the files if you care about them, remove them if you don't care.

5. If you had checkout problems, re-run:

	```
	dotfiles checkout
	```

6. Set the flag `showUntrackedFiles` to "no" on this specific (local) repository

	```
	dotfiles config --local status.showUntrackedFiles no
	```

7. Celebrate! You're done and can use the same commands mentioned in the "Usage" section.

## Resources

1. Taken and adpated from [Hacker News](https://news.ycombinator.com/item?id=11070797)
2. Taken and adapted from [Atlassian](https://www.atlassian.com/git/tutorials/dotfiles)