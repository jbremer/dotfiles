
if [ "$OS" == "Windows_NT" ]; then
    alias _assign_dir='cp -rf'
    alias _assign_file='cp -f'
    echo '[x] Windows detected'
else
    alias _assign_dir='ln -s'
    alias _assign_file='ln -s'
    echo '[x] Linux detected'

    echo '[+] dropping .tmux.conf'
    _assign_file "$PWD/tmux-conf" ~/.tmux.conf
fi

echo '[+] dropping .vimrc'
_assign_file "$PWD/vimrc" ~/.vimrc

echo '[+] dropping .bash_aliases'
_assign_file "$PWD/bash-aliases" ~/.bash_aliases

echo '[+] installing vim-pathogen'
mkdir -p "$PWD/vimfiles/autoload" "$PWD/vimfiles/bundle"
curl -Sso "$PWD/vimfiles/autoload/pathogen.vim" \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo '[x] downloading and initializing all git submodules'
git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update

echo '[x] dropping all vimfiles'

if [ "$OS" == "Windows_NT" ]; then
    _assign_dir "$PWD/vimfiles" ~
else
    _assign_dir "$PWD/vimfiles" ~/.vim
fi

unalias _assign_file
unalias _assign_dir

echo '[x] initialized successfully'
