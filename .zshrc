# emacs mode ex). ctrl+a, ctrl+e
bindkey -e

#zsh-completions setting
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit -u

# zsh syntax hilighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# aws-cli completion
source /usr/local/share/zsh/site-functions/_aws

# aliases
alias ..='cd ../'
alias ls='ls -G'
alias la='ls -a -G'
alias ll='ls -l -G'

alias rewind='exec $SHELL -l'
alias zrc='vim ~/.zshrc'
alias zenv='vim ~/.zshenv'
alias vrc='vim ~/.config/nvim/init.vim'
export RBCONF='MAKE_OPTS=-j4 CFLAGS=-O3 CONFIGURE_OPTS="--disable-install-rdoc --with-iconv-dir=/usr/lib"'
alias -g be='bundle exec'
alias bip='bundle install --path vendor/bundle'
alias fs='foreman start'

#use spring gem enviroment
alias mig='rake db:migrate'
alias migret='rake db:migrate:reset'
alias taret='RAILS_ENV=test rake db:migrate:reset'
alias prep='RAILS_ENV=production rake assets:precompile'
alias drep='RAILS_ENV=development rake assets:precompile'
alias rsand='rails c --sandbox'
alias rapply='rake ridgepole:apply'
alias trapply='RAILS_ENV=test rapply'
alias smoke_spec='rspec `find spec -name "*spec.rb" | $(brew --prefix coreutils)/bin/gsort -R | head -n 42`'
alias gst='git status && git stash list'
alias gti="git"
#alias -g @@="origin/`git symbolic-ref --short -q HEAD`"

alias dree='mysql.server restart'
alias pree='pg_ctl -l /tmp/pg.log restart'
alias tags='ctags -R -f .tags'
alias jenkup='java -jar /usr/local/opt/jenkins/libexec/jenkins.war'
alias -g vim="nvim"
alias vi=vim
alias today="date +'%Y年%m月%d日'"
alias icbrew='brew cask search | peco | xargs brew cask info '

# ${fg[...]} や $reset_color をロード
autoload -U colors; colors

function rprompt-git-current-branch {
local name st color

if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
  return
fi
name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
if [[ -z $name ]]; then
  return
fi
st=`git status 2> /dev/null`
if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
  color=${fg[green]}
elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
  color=${fg[yellow]}
elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
  color=${fg_bold[red]}
else
  color=${fg[red]}
fi

# %{...%} は囲まれた文字列がエスケープシーケンスであることを明示する
# これをしないと右プロンプトの位置がずれる
echo "%{$color%}$name%{$reset_color%} "
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

#setting prompt
case ${UID} in
  0)
    PROMPT="%B%F{198}%/#%f%b "
    PROMPT2="%B%F{198}%_#%f%b "
    SPROMPT="%B%F{198}%r is correct? [n,y,a,e]:%f%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
      PROMPT="%K{31}${HOST%%.*} ${PROMPT}"
    RPROMPT='[`rprompt-git-current-branch`%~]'
    ;;
  *)
    PROMPT="%F{198}✘╹◡╹✘[%T]%f "
    PROMPT2="%F{198}%_%%%f "
    SPROMPT="%F{198}%r is correct? [n,y,a,e]:%f "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
      PROMPT="%K{31}${HOST%%.*} ${PROMPT}"
    RPROMPT='[`rprompt-git-current-branch`%~]'
    ;;
esac

#show prompt color code
colors(){
  for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
}

#autojump setting
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

#rbenv setting
eval "$(rbenv init -)"

#direnv setting
eval "$(direnv hook $0)"

#reload direnv
if [ -e .envrc ] ; then ;
  direnv reload ;
fi

# add git commands

## ghq search
gp(){ ghq list | peco --select-1 | xargs -I@ cd $(ghq root)/@ }

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

# setting tab title function
title(){
  echo -e "\033];$*\007"
}

#registel
reg() {
  local registel_path=$HOME/Documents/registel/$1.md
  if [ ! -e $registel_path ]; then
    touch $registel_path
  fi
  open -a Atom.app $registel_path
}
oreg(){
  local registel_dir=$HOME/Documents/registel/
  ag -l \\\. $rgistel_dir #| peco | xargs -I{} open "{}"
}

# niconico bgm
function peco-nico-bgm() {
  TAG=`echo "作業用BGM $*" | nkf -WwMQ | tr -d '\n' | tr = % | sed -e 's/%%/%/g'`
  ruby -r rss -e "RSS::Parser.parse(\"http://www.nicovideo.jp/tag/$TAG?rss=2.0\").channel.items.each {|item| puts item.link + \"\t\" + item.title}" | peco | while read line; do
    echo $line
    echo $line | awk '{print $1}' | niconico | mplayer - -novideo
  done
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
