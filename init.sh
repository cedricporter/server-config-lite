#!/bin/bash

ln -sf $PWD/.zshrc ~
ln -sf $PWD/.tmux.conf ~

# mkdir ~/.pip
# ln -sf $PWD/pip.conf ~/.pip/

git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# cd ~
# wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-4.4.0-Linux-x86_64.sh

git config --global color.status auto
git config --global color.diff auto
git config --global color.branch auto
git config --global color.interactive auto
