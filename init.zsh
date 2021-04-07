PROMPT='%~ %# '

export TERM='xterm-256color'
export LANG=en_US.UTF-8

export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=50000
export HISTSIZE=50000

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
