HISTSIZE=50000
HISTFILESIZE=100000

#PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(hs=$(git rev-parse --short HEAD 2>/dev/null); [[ -n $hs ]] && { br=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); br=${br%HEAD}; echo "(\[\033[01;34m\]${br:-$hs}\[\033[00m\])"; })\$ '
PS1='\[$(tput setaf 214)\](\t)\
\[$(tput setaf 226)\]\u\
\[$(tput setaf 220)\]@\
\[\033[01;32m\]\h\
\[\033[00m\]:\
\[\033[01;34m\]\w\
\[$(tput setaf 13)\]$(hs=$(git symbolic-ref -q --short HEAD 2>/dev/null \
                        || git describe --tags --exact-match 2>/dev/null \
                        || git rev-parse --short HEAD 2>/dev/null);\
                      [[ -n $hs ]] && echo "($hs)")\
\[\033[00m\]\$ '

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ..='command cd ..'
alias ...='command cd ../..'
alias ....='command cd ../../..'
alias .....='command cd ../../../..'
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
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

