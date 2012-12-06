
if [ "$OS" == "Windows_NT" ]; then
    alias _assign_file='cp -rf'
    echo Windows detected
else
    alias _assign_file='ln -s'
    echo Linux detected
fi

_assign_file $PWD/tmux-conf ~/.tmux.conf
_assign_file $PWD/vimrc ~/.vimrc
_assign_file $PWD/bash-aliases ~/.bash_aliases

# vim-pathogen
mkdir -p $PWD/vimfiles/autoload $PWD/vimfiles/bundle
curl -Sso $PWD/vimfiles/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# python_match.vim
git clone https://github.com/vim-scripts/python_match.vim $PWD/vimfiles/bundle

# python_pydoc.vim
git clone https://github.com/fs111/pydoc.vim $PWD/vimfiles/bundle

if [ "$OS" == "Windows_NT" ]; then
    _assign_file $PWD/vimfiles ~
else
    _assign_file $PWD/vimfiles ~/.vim
fi

unalias _assign_file
