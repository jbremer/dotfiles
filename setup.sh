if [ "$OS" == "Windows_NT" ]; then
    assign_dir='cp -rf'
    assign_file='cp -f'
    vim=gvim
    echo '[x] Windows detected'
else
    assign_dir='ln -s'
    assign_file='ln -s'
    vim=vim
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

echo '[x] setting mergetool up'
git config --global user.name 'Jurriaan Bremer'
git config --global user.email 'jurriaanbremer@gmail.com'
git config --global color.status always
git config --global color.branch always
git config --global color.ui always
git config --global color.diff always
git config --global merge.tool splice
git config --global mergetool.splice.cmd \
    $vim' -f $BASE $LOCAL $REMOTE $MERGED -c SpliceInit'
git config --global mergetool.splice.trustExitCode true

# try to locate python binary
if [ "$OS" == "Windows_NT" ]; then
    python=/c/python27/python.exe
else
    python=/usr/bin/python
fi

echo '[x] building flake8'
cd flake8
$python setup.py install --user
cd ..

echo '[x] dropping all vimfiles'

if [ "$OS" == "Windows_NT" ]; then
    $assign_dir "$PWD/vimfiles" ~
else
    $assign_dir "$PWD/vimfiles" ~/.vim
fi

echo '[x] initialized successfully'
