alias r='reset'

alias gr='grep -rni --colour=always'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

set -o vi

PATH=~/.local/bin:$PATH
PATH=~/bin:$PATH

if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

export LC_ALL=en_US.UTF-8

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\]$ "


if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [ -f ~/.cargo/env ]; then
    . ~/.cargo/env
fi

if [ -f ~/.rye/env ]; then
    . ~/.rye/env
fi
