#set zsh setting
setopt auto_pushd
setopt auto_cd
setopt list_packed
setopt nolistbeep
setopt transient_rprompt
fpath=(/usr/local/share/zsh-completions $fpath)

#set enviroment
export EDITOR="vim"
export SHELL=/usr/local/opt/zsh/bin/zsh
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
export PGDATA=/usr/local/var/postgres
export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/heroku/bin:$PATH     ### Added by the Heroku Toolbelt
export PATH=$GLASSFISH_HOME/bin:$PATH
