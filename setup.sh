
if [ "$OS" == "Windows_NT" ]; then
    alias _assign_file='cp -rf'
    echo '[x] Windows detected'
else
    alias _assign_file='ln -s'
    echo '[x] Linux detected'

    echo '[+] dropping .tmux.conf'
    _assign_file $PWD/tmux-conf ~/.tmux.conf
fi

echo '[+] dropping .vimrc'
_assign_file $PWD/vimrc ~/.vimrc

echo '[+] dropping .bash_aliases'
_assign_file $PWD/bash-aliases ~/.bash_aliases

echo '[+] installing vim-pathogen'
mkdir -p $PWD/vimfiles/autoload $PWD/vimfiles/bundle
curl -Sso $PWD/vimfiles/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo '[x] downloading all git repositories'
git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update

echo '[x] dropping all vimfiles'

if [ "$OS" == "Windows_NT" ]; then
    _assign_file $PWD/vimfiles ~
else
    _assign_file $PWD/vimfiles ~/.vim
fi

unalias _assign_file

echo '[x] initialized successfully'
