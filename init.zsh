export TERM='xterm-256color'
export LANG=en_US.UTF-8

export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=50000
export HISTSIZE=50000

# Enhance the experience of completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

alias shut='shutdown -h now'
alias sethp='export http_proxy="http://127.0.0.1:1080"; export https_proxy="http://127.0.0.1:1080"'
alias setsp='export http_proxy="socks5://127.0.0.1:1080"; export https_proxy="socks5://127.0.0.1:1080"'
alias unsetp='unset http_proxy; unset https_proxy'
alias xo='xdg-open'

# Plugin manager
export ZPLUG_HOME="$ZSH_CONFIG_DIR/installed-plugins"
source "$ZSH_CONFIG_DIR/plugin-manager/zplug/init.zsh"

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "jeffreytse/zsh-vi-mode"

# Install plugins if there are plugins that have not been installed.
if ! zplug check --verbose; then
  printf "[zplug] Install plugins? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to PATH.
zplug load

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

# .my_zshrc for per computer configuration.
[ -f "$HOME/.my_zshrc" ] && source "$HOME/.my_zshrc"

# .rd_alias: book reading aliases.
[ -f "$HOME/.rd_alias" ] && source "$HOME/.rd_alias"

zvm_after_init_commands+=('[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"')
