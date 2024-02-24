# how many commands
HISTSIZE=500000
# how many lines
HISTFILESIZE=1000000

__fc_exit_status() {
    local exit=$?
    if [[ ! "$exit" -eq 0 ]]; then
        echo "($exit)"
    fi
}

__fc_git_symbolic_name() {
    git symbolic-ref -q --short HEAD 2>/dev/null \
    || git describe --tags --exact-match 2>/dev/null \
    || git rev-parse --short HEAD 2>/dev/null
}

__fc_par() {
    if [[ -n "$1" ]]; then
        echo "($1)"
    else
        echo ""
    fi
}

# tput bold; tput setaf 1
PS1='\[\e[01;31m\]$(__fc_exit_status)\[$(tput sgr0)\]\
\[$(tput setaf 214)\](\t)\
\[$(tput setaf 226)\]\u\
\[$(tput setaf 220)\]@\
\[$(tput bold; tput setaf 2)\]\h\
\[$(tput sgr0)\]:\
\[$(tput bold; tput setaf 4)\]\w\
\[$(tput setaf 13)\]$(__fc_par $(__fc_git_symbolic_name))\
\[$(tput setaf 2)\]\$\
\[$(tput sgr0)\] '

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ..='command cd ..'
alias ...='command cd ../..'
alias ....='command cd ../../..'
alias .....='command cd ../../../..'
alias cd..='command cd ..'
alias .3='command cd ../../..'
alias .4='command cd ../../../..'
alias .5='command cd ../../../../..'

# Fuzzy-F
source ~/.local/bin/completion.bash
source ~/.local/bin/key-bindings.bash

# z - jump around
if [ -x "$(command -v lua)" ]; then
    # use z.lua
    eval "$(lua ~/.local/bin/z.lua --init bash enhanced once fzf)"
else
    # use z.sh
    source ~/.local/bin/z.sh
fi

alias c=z

# Golang
export PATH="/usr/local/go/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export GOPROXY=https://proxy.golang.com.cn,direct

# Cargo
source "$HOME/.cargo/env"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then . "$HOME/google-cloud-sdk/completion.bash.inc"; fi

# Ruby
export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# fbinfer
export PATH="$HOME/infer-linux64-v1.1.0/bin:$PATH"

# Jabba
[ -s "$HOME/.jabba/jabba.sh" ] && source "$HOME/.jabba/jabba.sh"

# SDKMAN
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Kubernetes
[ -x "$(command -v kubectl)" ] && source <(kubectl completion bash)
