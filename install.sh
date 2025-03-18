#!/bin/bash

DOTFILES_DIR=$(pwd)

if ! command -v zsh &> /dev/null; then
	echo "Installing zsh..."
	sudo apt update && sudo apt install -y zsh || brew install zsh
fi

if [ ! -d ~/.oh-my-zsh ]; then
       	echo "Installing oh-my-zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

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

ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/vim/.vimrc" ~/.vimrc
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES_DIR/oh-my-zsh/custom/themes" ~/.oh-my-zsh/custom/themes
ln -sf "$DOTFILES_DIR/oh-my-zsh/custom/plugins" ~/.oh-my-zsh/custom/plugins

echo "Dotfiles installed successfully!"
