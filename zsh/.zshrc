export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git colored-man-pages colorize pip python osx) 

[ -s $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh

[ -s /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -s /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Setup PyEnv
command -v pyenv > /dev/null && eval "$(pyenv init -)"
command -v pyenv-virtualenv-init > /dev/null && eval "$(pyenv virtualenv-init -)"

# Setup NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && source "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && source "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Setup fzf
[ -s $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
alias preview="fzf --preview 'bat --color \"always\" {}'"

# Useful aliases
eval $(thefuck --alias)
alias cat=bat
alias ls="exa -al"
alias ping="prettyping"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
[ -s /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

alias bench="hyperfine"
alias hexdump="hexyl"

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=_zsh_autosuggest_bound_7_self-insert
  zle -N self-insert url-quote-magic # I wonder if you'd need ?
}

pastefinish() {
  zle -N self-insert 
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

command -v tmux > /dev/null && (tmux attach || tmux new)

# Setup java
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"

command -v starship > /dev/null && eval "$(starship init zsh)"

# Setup neovim as editor
alias vim="nvim"
alias vi="nvim"
export EDITOR="nvim"
export VISUAL="nvim"

# Add SSH key
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add $HOME/.ssh/*
fi
