if [ "$OS" == "Windows_NT" ]; then
    assign_dir='cp -rf'
    assign_file='cp -f'
    echo '[x] Windows detected'
else
    assign_dir='ln -s'
    assign_file='ln -s'
    echo '[x] Linux detected'

    echo '[+] dropping .tmux.conf'
    $assign_file "$PWD/tmux-conf" ~/.tmux.conf
fi

echo '[+] dropping .vimrc'
$assign_file "$PWD/vimrc" ~/.vimrc

if [ ! -f ~/.bashrc ]; then
    echo '[+] no .bashrc found, dropping one now'
    $assign_file "$PWD/bashrc" ~/.bashrc
fi

echo '[+] dropping .bash_aliases'
$assign_file "$PWD/bash-aliases" ~/.bash_aliases

echo '[+] installing vim-pathogen'
mkdir -p "$PWD/vimfiles/autoload" "$PWD/vimfiles/bundle"
curl -Sso "$PWD/vimfiles/autoload/pathogen.vim" \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo '[x] initializing all git submodules'
git submodule init

echo '[x] cloning all git submodules'
git submodule update

# try to locate python binary
if [ "$OS" == "Windows_NT" ]; then
    python=/c/python27/python.exe
else
    python=/usr/bin/python
fi

echo '[x] building flake8'
cd flake8
$python setup.py build
cd ..

# build path of flake8
echo pathadd \"$PWD/flake8/build/scripts-2.7\" >> ~/.bash_aliases_auto

echo '[x] dropping all vimfiles'

if [ "$OS" == "Windows_NT" ]; then
    $assign_dir "$PWD/vimfiles" ~
else
    $assign_dir "$PWD/vimfiles" ~/.vim
fi

echo '[x] initialized successfully'
