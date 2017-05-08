#!/bin/bash

ln -sf $PWD/.zshrc ~
ln -sf $PWD/.tmux.conf ~

git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
