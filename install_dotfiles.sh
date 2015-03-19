#!/bin/bash
DIR=$(dirname $0)

if [ -e ~/.vimrc ]
then
    echo ".vimrc exists, moving it to .vimrc.bak"
    mv ~/.vimrc ~/.vimrc.bak
fi
ln -s $DIR/vimrc ~/.vimrc

if [ -e ~/.bashrc ]
then
    echo ".bashrc exists, moving it to .bashrc.bak"
    mv ~/.bashrc ~/.bashrc.bak
fi
ln -s $DIR/bashrc ~/.bashrc

if [ -e ~/.inputrc ]
then
    echo ".inputrc exists, moving it to .inputrc.bak"
    mv ~/.inputrc ~/.inputrc.bak
fi
ln -s $DIR/inputrc ~/.inputrc

if [ -e ~/.tmux.conf ]
then
    echo ".tmux.conf exists, moving it to .tmux.conf.bak"
    mv ~/.tmux.conf ~/.tmux.conf.bak
fi
ln -s $DIR/tmux.conf ~/.tmux.conf

