#!/usr/bin/env bash
set -e

# Install Homebrew.
set +e
which brew >/dev/null 2>&1
status=$?
set -e
if [[ $status -ne 0 ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Random software
brew install \
  git \
  httpie \
  python \
  python3 \
  thefuck \
  z

# Fish
brew install fish
# Oh my Fish
current_dir=$(pwd)
if [[ ! -d 'vendor/oh-my-fish' ]]; then
  cd vendor/
  git clone https://github.com/oh-my-fish/oh-my-fish
  cd oh-my-fish
  bin/install --offline
  cd $current_dir
fi
# Default shell
chsh -s $(which fish)

# Remove outdated versions from the cellar.
brew cleanup
