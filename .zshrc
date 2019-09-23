bindkey -v
set -o vi
KEYTIMEOUT=1

export EDITOR=vim
export VISUAL=vim

# Terminal colors
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

# FZF bindings & completion
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

#Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-interactive-cd.plugin.zsh

# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# projects aliases
alias radaro='cd ~/projects/delivery-front && gulp'
alias etools='cd ~/projects/etools-infra && fab devup:quick'

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --height 40%" 

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Git checkout with fzf
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
# Kill process with zfz
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
# NPM install with fzf
fnpm() {
    local packages
    packages=$(all-the-package-names | fzf -m) &&
    echo "$packages" &&
    npm i $(echo $packages)
}

