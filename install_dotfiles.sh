#!/bin/bash
DIR=$(dirname $0)

if [ -e ~/.vimrc ]
then
    echo ".vimrc exists, moving it to .vimrc.bak"
    mv ~/.vimrc ~/.vimrc.bak
    ln -s $DIR/vimrc ~/.vimrc
fi

if [ -e ~/.bashrc ]
then
    echo ".bashrc exists, moving it to .bashrc.bak"
    mv ~/.bashrc ~/.bashrc.bak
    ln -s $DIR/bashrc ~/.bashrc
fi

if [ -e ~/.inputrc ]
then
    echo ".inputrc exists, moving it to .inputrc.bak"
    mv ~/.inputrc ~/.inputrc.bak
    ln -s $DIR/inputrc ~/.inputrc
fi

if [ -e ~/.tmux.conf ]
then
    echo ".tmux.conf exists, moving it to .tmux.conf.bak"
    mv ~/.tmux.conf ~/.tmux.conf.bak
    ln -s $DIR/tmux.conf ~/.tmux.conf
fi

