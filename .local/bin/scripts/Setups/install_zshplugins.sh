#!/bin/sh

echo "ZSH COMPLETIONS"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.local/share/oh-my-zsh}/custom}/plugins/zsh-completions

echo "ZSH SYNTAX HIGHLIGHTING"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.local/share/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "ZSH AUTOSUGGESTIONS"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.local/share/oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "ZSH CATPPUCCIN MOCHA FOR SYNTAX HIGHLIGHTING"
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git
cp zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh ${ZSH_CUSTOM:-~/.local/share/oh-my-zsh/custom}/themes
rm -fr zsh-syntax-highlighting
