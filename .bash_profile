alias r='reset'

alias gr='grep -rni --colour=always'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

set -o vi

PATH=$PATH:~/bin

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

export LC_ALL=en_US.UTF-8

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\]$ "

#### Python env ####
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PATH="$HOME/.poetry/bin:$PATH"
#### Python env ####

#### Rust env ####
. "$HOME/.cargo/env"
#### Rust env ####
