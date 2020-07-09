# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode
  sudo
  extract
  archlinux
  node
)

source "$ZSH/oh-my-zsh.sh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Create a zkbd compatible hash. To add other keys to this hash, see: man 5
# terminfo.
typeset -g -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"

# Bind some extra keys in vi-mode.
# Home/End: beginning/end of line.
for mode in viins vicmd
do
  bindkey -M $mode "${key[Home]}" beginning-of-line
  bindkey -M $mode "${key[End]}" end-of-line
done
# kj: escape from insert mode.
bindkey -M viins kj vi-cmd-mode

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias shut='shutdown -h now'
alias sethp='export http_proxy="http://127.0.0.1:1080"; export https_proxy="http://127.0.0.1:1080"'
alias setsp='export http_proxy="socks5://127.0.0.1:1080"; export https_proxy="socks5://127.0.0.1:1080"'
alias unsetp='unset http_proxy; unset https_proxy'
alias xo='xdg-open'

# Plugin manager
export ZPLUG_HOME="$ZSH_CONFIG_DIR/installed-plugins"
source "$ZSH_CONFIG_DIR/plugin-manager/zplug/init.zsh"

zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install plugins if there are plugins that have not been installed.
if ! zplug check --verbose; then
  printf "[zplug] Install plugins? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to PATH.
zplug load --verbose

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

# .my_zshrc for per computer configuration.
[ -f "$HOME/.my_zshrc" ] && source "$HOME/.my_zshrc"

# .rd_alias: book reading aliases.
[ -f "$HOME/.rd_alias" ] && source "$HOME/.rd_alias"

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
