alias cd..='cd ..'
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(hs=$(git rev-parse --short HEAD 2>/dev/null); [[ -n $hs ]] && { br=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); br=${br%HEAD}; echo "(\[\033[01;34m\]${br:-$hs}\[\033[00m\])"; })\$ '
