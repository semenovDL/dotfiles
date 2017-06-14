export DOTFILES=$HOME/.dotfiles
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$DOTFILES/install/zsh/custom

ZSH_THEME="semenovdl"

plugins=(git redis-cli gem rbenv bundler rails docker zsh-syntax-highlighting)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)

source $ZSH/oh-my-zsh.sh

# Language Environment
export LC_ALL=ru_RU.UTF-8
export LANG=ru_RU.UTF-8

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
# ssh-add

# Alias
alias gh=$HOME/p/gh
alias sb=$HOME/p/sb
alias oss=$HOME/p/oss
alias gb=$HOME/p/gb/geekbrains

alias gs='git status'
alias gcm='git c'

alias d='docker'
alias di='docker images'
alias drm='docker ps -a -q | xargs docker rm'
alias drmi='docker images -q --filter "dangling=true" | xargs docker rmi'
alias drmv='docker volume rm $(docker volume ls -qf dangling=true)'

# alias rails='bundle exec rails'
# alias rake='bundle exec rake'
# alias rspec='bundle exec rspec'
# alias foreman='bundle exec foreman'
# alias cap='bundle exec cap'
# alias mina='bundle exec mina'

# Alias to script
alias _rsync='rsync -azh --delete --info=progress2 --exclude '.git' --exclude '.gitignore''
alias _backup='rsync -zavP --delete --exclude /Users/semenovDL/Downloads --exclude /Users/semenovDL/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux --exclude /Volumes / root@192.168.1.254:/home/backup_mirror/macbook'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Keybinding
bindkey '^[delete' backward-delete-word
bindkey "^[[1;5A" beginning-of-line # Home
bindkey "^[[1;5B" end-of-line # End
bindkey "^[D" backward-word
bindkey "^[C" forward-word

# Functions
# Recursively delete `.DS_Store` files
function cleanup() { find $1 -type f -name '*.DS_Store' -ls -delete }

# FZF
# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
