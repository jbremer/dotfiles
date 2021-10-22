# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH="$PATH:/usr/local/go/bin:/home/jbr/go/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR=vim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

setopt no_share_history

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias py=python
alias ipy='ipython --pdb'
alias mosh='LC_ALL=en_US.UTF-8 mosh'
alias mk=make
alias mc='make clean'
alias mck='make clean && make'
alias mkc='make -C'
alias tmp='cd /tmp'

alias ga='git add'
alias gap='git add -p'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -D'
alias gc='git commit'
alias gch='git checkout'
alias gchb='git checkout -b'
alias gchm='git checkout main'
alias gfo='git fetch origin'
alias gm='git merge'
alias gmt='git mergetool'
alias grh='git reset HEAD'
alias grsh='git reset --soft HEAD~'
alias gpl='git pull'
alias gplo='git pull origin'
alias gplom='git pull origin main'
alias gplr='git pull -r'
alias gplro='git pull -r origin'
alias gplrom='git pull -r origin main'
alias gps='git push'
alias gpso='git push origin'
alias gpsom='git push origin main'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gss='git stash save'
alias gsp='git stash pop'

alias cac='git diff --cached'
alias gd='git diff'
alias gl='git log'
alias gsh='git show'
alias ghs=gsh
alias gs=gsh
alias gst='git status'

gcam() {
    git commit -am "$*" || {
        echo Nothing to commit, going to --amend now.
        read
        [ "$?" -eq 0 ] && git commit -am "$*" --amend
    }
}

gcm() {
    git commit -m "$*" || {
        echo Nothing to commit, going to --amend now.
        read
        [ "$?" -eq 0 ] && git commit -m "$*" --amend
    }
}

g() {
    if git status 1>/dev/null 2>/dev/null; then
        git grep $*
    else
        grep -r $*
    fi
}

gi() {
    if git status 1>/dev/null 2>/dev/null; then
        git grep -i $*
    else
        grep -ir $*
    fi
}

upload() {
    local sha1=$(sha1sum "$1"|cut -d' ' -f1|head -c16)
    local bname=$(basename "$1")
    ssh jbr@cuckoo.sh "mkdir -p /var/www/cuckoo.sh/temp/$sha1"
    scp "$1" "jbr@cuckoo.sh:/var/www/cuckoo.sh/temp/$sha1/$bname"
    ssh jbr@cuckoo.sh "chmod o+r /var/www/cuckoo.sh/temp/$sha1/$bname"
    echo "https://cuckoo.sh/temp/$sha1/$bname"
    echo "https://cuckoo.sh/temp/$sha1/$bname" |xsel -i
}

upldev() {
    local sha1=$(sha1sum "$1"|cut -d' ' -f1|head -c16)
    local bname=$(basename "$1")
    ssh root@hatching.dev "mkdir -p /var/www/hatching/temp/$sha1"
    scp "$1" "root@hatching.dev:/var/www/hatching/temp/$sha1/$bname"
    ssh root@hatching.dev "chmod o+r /var/www/hatching/temp/$sha1/$bname"
    echo "https://hatching.dev/temp/$sha1/$bname"
    echo "https://hatching.dev/temp/$sha1/$bname" |xsel -i
}

p() {
    local dir="/tmp/.secret_pastes"
    mkdir -p "$dir"
    cat - > "$dir/paste.txt" && upload "$dir/paste.txt"
    rm -rf "$dir"
}

alias gfu="fu -d $'\x1b[36m--\x1b[m'"

alias gp='xsel -b|p'
alias scr='sleep 1; scrot -s /tmp/screenshot.png; upload /tmp/screenshot.png'
alias scrdev='sleep 1; scrot -s /tmp/screenshot.png; upldev /tmp/screenshot.png'

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
