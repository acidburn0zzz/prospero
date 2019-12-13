# Git guidelines

Prospéro contributors must use version **2.0** or later of Git.

Please check your Git version by running:

```sh
git --version
```

## Required configuration

#### Set your identity

Set the name and e-mail address you wish to be written in your commits:

_It doesn't need to be your "real" name (whatever it may mean), but please provide a valid e-mail address._

```sh
git config --global user.name "Your Full-name"
git config --global user.email name@domain.whatever
```

_Example:_


```sh
git config --global user.name "Lobster"
git config --global user.email lobster@riseup.net
```

## Recommended configuration

#### Set automatic pull rebase

In order to avoid useless [merge](https://git-scm.com/docs/git-merge) commits everytime you [pull](https://www.git-scm.com/docs/git-pull) changes from the remote repository, set automatic [rebase](https://git-scm.com/book/en/v2/Git-Branching-Rebasing) option.

```sh
git config --global pull.rebase true
```

#### Set Vim as [core editor](https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#_code_core_editor_code)

Install [Vim](https://www.vim.org/).

Make sure Vim is available by running:

```sh
vim --version
```

Set Vim as Git core editor by running:

```sh
git config --global core.editor vim
```

#### Set Meld as [merge tool](https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#_external_merge_tools)

Install [Meld](https://meldmerge.org/).

Make sure Meld is available by running:

```sh
meld --version
```

Set Meld as default Merge-tool by running:

```sh
git config --global merge.tool meld
```

#### Add pretty log alias

Add a `lg` alias for pretty version of `git log` by running:

```sh
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
```

Try it by running:

```sh
git lg
```

Compare it with the default command output:

```sh
git log
```

...and chose the one you prefer keep using.

## Commit messages

Commit messages are very important, please take the time to read [this article](https://chris.beams.io/posts/git-commit/) about how to write good Git commit messages.
