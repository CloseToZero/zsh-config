PROMPT='%~ %# '

export TERM='xterm-256color'
export LANG=en_US.UTF-8

export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=50000
export HISTSIZE=50000

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'


# Plugin manager
declare -A ZINIT
ZINIT[HOME_DIR]="$ZSH_CONFIG_DIR/.cache/zinit"
source "$ZSH_CONFIG_DIR/plugin-manager/zinit/zinit.zsh"

# Enhance the experience of completion
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z-_}={A-Za-z_-}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)

alias shut='shutdown -h now'
alias sethp='export http_proxy="http://127.0.0.1:1080"; export https_proxy="http://127.0.0.1:1080"'
alias setsp='export http_proxy="socks5://127.0.0.1:1080"; export https_proxy="socks5://127.0.0.1:1080"'
alias unsetp='unset http_proxy; unset https_proxy'
alias xo='xdg-open'
alias ls='ls --color=auto'
alias ll='ls -al'

zinit light zsh-users/zsh-autosuggestions

zinit light zdharma/fast-syntax-highlighting

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

zinit ice atclone"./install --bin" as"program" pick"bin/fzf"
zinit light junegunn/fzf

# Config of zsh-vi-mode
# jj: escape from insert mode.
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
# M-n/M-p: down/up history in insert/normal modes
for keymap in vicmd viins
do
  zvm_bindkey $keymap '^[n' down-history
  zvm_bindkey $keymap '^[p' up-history
done

# ctrl+space to accept the current suggestion
zvm_bindkey viins '^ ' autosuggest-accept

# Use vi keys to navigate between menu items
zvm_bindkey menuselect 'j' vi-down-line-or-history
zvm_bindkey menuselect 'k' vi-up-line-or-history
zvm_bindkey menuselect 'h' vi-backward-char
zvm_bindkey menuselect 'l' vi-forward-char

add_existed_dir_to_path() {
  if [ -d "$1" ]
  then
    if [[ $PATH =~ "$1" ]]; then
      return 0
    fi

    if [ "$2" = "prepend" ]; then
      export PATH="$1:$PATH"
    else
      export PATH="$PATH:$1"
    fi
  fi
  return 0
}

add_existed_dir_to_path "$HOME/bin"
add_existed_dir_to_path "$HOME/.roswell/bin"
add_existed_dir_to_path "$HOME/.local/bin"
add_existed_dir_to_path "$HOME/.yarn/bin"
add_existed_dir_to_path "$HOME/my-scripts"

function my_init_fzf() {
  local script="$ZINIT[HOME_DIR]/plugins/junegunn---fzf/shell/key-bindings.zsh"
  [ -f "$script" ] && source "$script"
}

zvm_after_init_commands+=(my_init_fzf)

# .my_zshrc for per computer configuration.
[ -f "$HOME/.my_zshrc" ] && source "$HOME/.my_zshrc"

# .rd_alias: book reading aliases.
[ -f "$HOME/.rd_alias" ] && source "$HOME/.rd_alias"
