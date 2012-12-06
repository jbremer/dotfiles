
if [ "$OS" == "Windows_NT" ]; then
    alias _assign_file='cp -rf'
else
    alias _assign_file='ln -s'
fi

_assign_file $PWD/tmux-conf ~/.tmux.conf
_assign_file $PWD/vimrc ~/.vimrc
_assign_file $PWD/bash-aliases ~/.bash_aliases

if [ "$OS" == "Windows_NT" ]; then
    _assign_file $PWD/vimfiles ~
else
    _assign_file $PWD/vimfiles ~/.vim
fi

unalias _assign_file
