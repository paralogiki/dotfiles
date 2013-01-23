if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
PATH=$PATH:$HOME/.bin
export PATH

# Gimme a huge history
export HISTSIZE=50000

# Don't store duplicate lines in history
export HISTCONTROL=ignoreboth

# Apend to history instead of overwriting
shopt -s histappend

# Unify histories across screen sessions
export PROMPT_COMMAND="history -a; history -n"
