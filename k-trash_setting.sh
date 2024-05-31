#!/bin/sh

echo -e '{\n\t"keyboard.dispatch": "keyCode"\n}' > $HOME/.config/Code/User/settings.json
touch $HOME/.vimrc
echo -e 'set number\nset smartindent' >> $HOME/.vimrc

apt -y install wireshark
