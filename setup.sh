ln -s $PWD/tmux-conf ~/.tmux.conf
ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/bash-aliases ~/.bash_aliases

if [ "$OS" == "Windows_NT" ]; then
    cp -rf $PWD/vimfiles ~
else
    ln -s $PWD/vimfiles ~/.vim
fi
