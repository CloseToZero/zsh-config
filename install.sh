#!/bin/sh -

DIR=$(cd "$(dirname "$0")";pwd)
CONFIG="$DIR/init.zsh"
WRAPPER="$DIR/init-wrapper.zsh"
INSTALL="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.back"

cat <<EOF > "$WRAPPER"
ZSH_CONFIG_DIR='$DIR'
source '$CONFIG'
EOF

if [ -f "$INSTALL" ]; then
  echo "Config $INSTALL already exists, backup it as $BACKUP"
  cp "$INSTALL" "$BACKUP"
fi

echo "Install to $INSTALL"
ln -sf "$WRAPPER" "$INSTALL"
