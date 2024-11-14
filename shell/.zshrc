# --- Paths & Environment Variables ---

# Path to your oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# Add Yarn, Node, and Pyenv to PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="/usr/local/opt/node@12/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"  # Added by pipx

# Google Cloud SDK
if [ -f "$HOME/Documents/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/Documents/google-cloud-sdk/path.zsh.inc"
fi

# GPG TTY fix for Brew GPG+Git
export GPG_TTY=$(tty)

# Node warning suppression
export NODE_NO_WARNINGS=1

# Enable Go Modules
export GO111MODULE=on

# Zplug home
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

# --- Oh-My-Zsh Configuration ---

# Set theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
  git
)

# Oh-my-zsh source
source $ZSH/oh-my-zsh.sh

# --- Aliases ---

# Editor
alias vim=nvim
alias zshrc="vim ~/.zshrc"

# Environment
alias swdev="export NODE_ENV=development"
alias swprod="export NODE_ENV=production"

# Tmux
alias tmux="TERM=screen-256color-bce tmux"

# Custom script alias
alias gpt="python3 ~/gpt-prompt.py"

# Commands to manage background processes
alias gimme="fc -ln -1 | { read last_command; echo Command: \$last_command; eval \$last_command | tee /tmp/command_output; echo Result: \$(cat /tmp/command_output); } | tmux load-buffer -"

# --- Functions ---

# Docker shell access
function dbash() {
  docker exec -it $1 /bin/bash 
}

# Kill a process blocking a port
function killport() {
  PROCESS_COUNT="$(sudo lsof -i:$1 | wc -l)"
  if [ "$PROCESS_COUNT" != "       0" ]; then
    echo "${PROCESS_COUNT} process(es) blocking port:"
    lsof -i:$1 | grep -E '\w+ \s+ (\d+)' -o
    echo "\nKilling the first one…"
    PID="$(sudo lsof -i:$1 | grep -E '[0-9]+' -o | head -1)"
    if [ "$PID" != "" ]; then
      echo "Killing app using port ${1}"
      kill -9 $PID
    fi
  else
    echo "No processes blocking port $1"
  fi
}

# --- User & System Configuration ---

# Set preferred editor for SSH/local sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Autocomplete and auto-suggestion plugins
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Direnv for directory-based environment variables
eval "$(direnv hook zsh)"

# --- Node Version Manager (NVM) ---

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # Load nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # Load nvm bash_completion

# --- Pyenv Initialization ---

eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# --- Google Cloud SDK Autocompletion ---

if [ -f "$HOME/Documents/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/Documents/google-cloud-sdk/completion.zsh.inc"
fi
