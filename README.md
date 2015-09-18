# Git Plugins [![Build Status](https://travis-ci.org/afeld/git-plugins.svg?branch=travis)](https://travis-ci.org/afeld/git-plugins)

A community collection of Git plugins.

## Setup

```bash
git clone git@github.com:afeld/git-plugins.git
```

Then add the following to your `~/.bash_profile` (or `~/.zshrc`, or whatever profile file you use):

```bash
export PATH=path/to/git-plugins/bin:$PATH
```

## Aliases

The plugin names intentionally favor descriptiveness over terseness, but you should make shortcuts for yourself that make sense for you.  You can see some examples in the `[alias]` section of [afeld/dotfiles](https://github.com/afeld/dotfiles/blob/master/gitconfig).  To add a new shortcut:

```bash
git config --global alias.SHORT LONG

# you can then use
git SHORT
```

e.g.

```bash
git config --global alias.lg pretty-log

# enables
git lg
```

## Example workflow

If you are doing something like the [GitHub Flow](https://guides.github.com/introduction/flow/), working on a typical feature might look like this:

```bash
git fetch origin
git checkout -b feature-branch --no-track origin/master

# make some changes, add some files

git add -A
git commit -m "fixed stuff"

git push -u origin feature-branch

# open your repository on github.com, and click the button to make a new pull request
```

That is _so much typing!_ Using these plugins, your workflow can be simplified to:

```bash
git f feature-branch

# make some changes, add some files

git ca -m "fixed stuff"
git pr
```

So much better! :zap: To use this workflow, go through the [setup](#setup) above, then run the following to set up the aliases:

```bash
git config --global alias.ca commit-all
git config --global alias.f create-feature-branch
git config --global alias.pr create-pull-request
```

## See Also

* [EasyGit](https://people.gnome.org/~newren/eg/)
* [ghi](https://github.com/stephencelis/ghi)
* [git-flow](https://github.com/nvie/gitflow)
* [git-setup](https://github.com/afeld/git-setup)
* [hub](http://hub.github.com/)
* [HubFlow](http://datasift.github.io/gitflow/)
* [Legit](http://www.git-legit.org/)
