
# Set up the prompt
 
autoload -Uz promptinit
promptinit
 
setopt histignorealldups sharehistory
 
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
 
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# time
PROMPT='[%n@%m]'
RPROMPT='[%*]'

# Use modern completion system
autoload -Uz compinit
compinit
 
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2  #保管候補に色をつける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors 'di=36' 'ln=35'
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
 
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
 
#エイリアス
alias cp='cp -i'
alias mv='mv -i'
alias tree='tree -F'
# alias lsls='/bin/ls'
if [ -n $TMUX ]; then
	alias imgcat='imgcat_tmux'
fi

#os依存
PLATFORM=`uname`
if [ "$PLATFORM" = 'Darwin' ]; then
	prompt adam1 66
	alias ls='ls -F -G'
	alias l='ls -F -G'
	alias la='ls -aF -G'
	alias ll='ls -lhF -G'
	alias lla='ls -alhF -G'
elif [ "$PLATFORM" = 'Linux' ]; then
	prompt adam1 67 #60 #17 #31 #65
	eval "$(dircolors -b)"
	alias ls='ls -F --color=auto'
	alias l='ls -F --color=auto'
	alias la='ls -aF --color=auto'
	alias ll='ls -lhF --color=auto'
	alias lla='ls -alhF --color=auto'
else
	echo "$PLATFORM"
	echo "loading .zshrc error!!"
	echo "loading .zshrc error!!"
	echo "loading .zshrc error!!"
	echo "loading .zshrc error!!"
fi
 
# ローカル設定
if [ -e "${HOME}/.zshrc.local" ]; then
	source ~/.zshrc.local
fi
 
#その他
setopt correct  #入力ミスに対応する
setopt HIST_IGNORE_DUPS  #直前のコマンドと同じなら履歴に残さない
setopt menu_complete  #タブ保管を一回目から
setopt auto_pushd  #移動したディレクトリを記憶
setopt list_packed  #保管候補を詰めて表示
setopt pushd_ignore_dups  #ディレクトリスタックに同じものを積まない
setopt print_exit_value # 終了ステータスが0以外のとき表示
setopt nolistbeep # ビープ音ならさない
setopt auto_cd
 
#環境変数
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
#export PATH="${PATH}:${HOME}/bin" # シェルスクリプトとか
 
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=$HOME/bin:$PATH:/usr/local/bin

#color
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'

#C-s 無効
stty stop undef
stty start undef

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
