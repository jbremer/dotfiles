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

    echo '[+] Installing various packages'
    sudo apt-get install -y $(cat packages.txt)
fi

echo '[+] dropping .vimrc'
$assign_file "$PWD/vimrc" ~/.vimrc

# vim on windows vista appears to include ~/_vimrc for an unknown reason
if [ "$OS" == "Windows_NT" ]; then
    $assign_file "$PWD/vimrc" ~/_vimrc
fi

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
    $vim' -f $BASE $LOCAL $REMOTE $MERGED -c SpliceInit ' \
    '-u ~/git/dotfiles/vimrc-splice'
git config --global mergetool.splice.trustExitCode true

echo '[x] installing flake8'
sudo pip install flake8

echo '[x] dropping all vimfiles'
$assign_dir "$PWD/vimfiles" ~/.vim

echo '[x] setting up i3'
mkdir -p ~/.i3
$assign_file "$PWD/i3-config" ~/.i3/config

echo '[x] applying some configuration'
# don't show the "Desktop" window when nautilus pops up
gsettings set org.gnome.desktop.background show-desktop-icons false

# Disable Totem (Ubuntu Media Player) history.
rm ~/.local/share/recently-used.xbel
touch ~/.local/share/recently-used.xbel
chmod 0 ~/.local/share/recently-used.xbel

# Disable Recently Used.
zeitgeist-daemon -q
rm ~/.local/share/zeitgeist/activity.sqlite
touch ~/.local/share/zeitgeist/activity.sqlite
chmod 0 ~/.local/share/zeitgeist/activity.sqlite

echo '[x] initialized successfully'
