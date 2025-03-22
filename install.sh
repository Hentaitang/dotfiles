#!/bin/bash

ARCH=$(arch)
DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)
CUSTOM_THEMES_DIR="$DOTFILES_DIR/oh-my-zsh/custom/themes"
CUSTOM_PLUGINS_DIR="$DOTFILES_DIR/oh-my-zsh/custom/plugins"

if ! command -v zsh &> /dev/null; then
	echo "Installing zsh..."
	sudo apt update && sudo apt install -y zsh || brew install zsh
fi

if [ ! -d $HOME/.oh-my-zsh ]; then
       	echo "Installing oh-my-zsh..."
	RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d "$HOME/.nvm" ]; then
	echo "Installing nvm..."
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
fi

if [ "$ARCH" != "aarch64" ]; then
	if ! command -v brew &> /dev/null; then
		echo "Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	echo "Updating Homebrew..."
	brew update

	echo "Installing tools from Brewfile..."
	brew bundle install

	echo "Brew cleaning up..."
	brew cleanup
fi


ln -sf "$DOTFILES_DIR/zsh/.zshrc" $HOME/.zshrc
ln -sf "$DOTFILES_DIR/vim/.vimrc" $HOME/.vimrc
ln -sf "$DOTFILES_DIR/git/.gitconfig" $HOME/.gitconfig
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" $HOME/.tmux.conf

if [ -d "$HOME/.oh-my-zsh/custom" ]; then
	rm -rf $HOME/.oh-my-zsh/custom/* 
fi	
ln -sf "$CUSTOM_THEMES_DIR" $HOME/.oh-my-zsh/custom/themes
ln -sf "$CUSTOM_PLUGINS_DIR" $HOME/.oh-my-zsh/custom/plugins

echo "Initializing submodules..."
git submodule update --init --recursive

echo "Dotfiles installed successfully!"
exec zsh

