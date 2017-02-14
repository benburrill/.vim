# My vim configuration

The first step in my attempt to make a dotfiles repo for myself.  This repo works quite well on its own due to its very simple installation.

## Installation
Clone this to `~/.vim` (or `%USERPROFILE%\vimfiles` on windows).  Use the [`--recursive` flag](https://www.git-scm.com/docs/git-clone#git-clone---recursive) in order to get all the plugins properly.

## Usage
Plugin management is done with [pathogen](https://github.com/tpope/vim-pathogen).  Use `repo-to-submodule.sh` to convert plugin repos into git submodules.  Ideally, I should remember to use `git submodule add` each time instead of `git clone`, but `repo-to-submodule.sh` will fix that when I inevitably forget.

Platform-specific settings can be added in `~/.vimrc` or `~/.gvimrc`.  However, they must source their counterpart in this configuration directory or they will completely override it.

On older versions of vim, a `~/.vimrc` and `~/.gvimrc` must be created (again remember to source) because `~/.vim/vimrc` isn't recognized.  The best solution is to use a more recent version of vim though.
