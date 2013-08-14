# Git Plugins

A community collection of Git plugins.

## Setup

```bash
git clone git@github.com:afeld/git-plugins.git
```

Then add the following to your `~/.bash_profile` (or `~/.zshrc`, or whatever profile file you use):

```bash
export PATH=path/to/git-plugins:$PATH
```

## Aliases

The plugin names intentionally favor descriptiveness over terseness, but you should make shortcuts for yourself that make sense for you.  You can see some examples in [these dotfiles](https://github.com/afeld/dotfiles/blob/1c41cffb723bffa23f5b66f66fd2dd767e98c75b/gitconfig#L15-19).  To add a new shortcut:

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

## See Also

* [EasyGit](https://people.gnome.org/~newren/eg/)
* [ghi](https://github.com/stephencelis/ghi)
* [git-flow](https://github.com/nvie/gitflow)
* [hub](http://hub.github.com/)
* [HubFlow](http://datasift.github.io/gitflow/)
* [Legit](http://www.git-legit.org/)
