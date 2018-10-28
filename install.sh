#!/usr/bin/env bash
set -e
echo "=== starting installation ==="

# Install Homebrew.
set +e
which brew >/dev/null 2>&1
status=$?
set -e
if [[ $status -ne 0 ]]; then
  echo "=== Installing Homebrew ==="
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

###
# Homebrew
###
echo "=== Update & Upgrade Homebrew ==="
# Make sure we’re using the latest Homebrew.
brew update
# Upgrade any already-installed formulae.
brew upgrade

###
# Software that doesn't need anything special
###
echo "=== Install from Homebrew ==="
brew install \
  # android-platform-tools \
  aria2 \
  bash \
  colordiff \
  # ffmpeg \
  findutils \
  # gifsicle \
  git \
  git-flow-avh \
  graphicsmagick \
  graphviz \
  grep \
  httpie \
  iproute2mac \
  nmap \
  npm \
  pipenv \
  # php71 \
  # this is python 3
  python \
  python@2 \
  ruby \
  slackcat \
  terraform \
  thefuck \
  z

###
# Links
###
brew link ruby

###
# Taps
###
brew tap homebrew/services

###
# Casks
##
echo "=== Install from Homebrew Casks ==="
brew tap caskroom/cask
brew tap caskroom/versions
brew cask install \
  adobe-reader \
  # android-studio \
  atom \
  caskroom/fonts/font-hack \
  # crashplan \
  dropbox \
  docker \
  firefox \
  freedome \
  gimp \
  google-chrome \
  java \
  keepingyouawake \
  moom \
  # ngrok \
  pycharm-ce \
  rocket \
  skype-for-business \
  slack \
  spotify \
  spotify-notifications \
  tunnelblick \
  visual-studio-code \
  vlc \
  wireshark

###
# Pip
###
echo "=== Install from pip ==="
pip2 install --upgrade -r pip2-packages.txt
pip3  install --upgrade -r pip3-packages.txt

###
# npm
##
npm install -g serverless
npm install -g cloudformation-graph
npm install -g aws-sam-local

###
# Fish
###

# Install fish
echo "=== Install fish and oh my fish ==="
brew install fish
# Install Oh my Fish
current_dir=$(pwd)
if [[ ! -d 'vendor/oh-my-fish' ]]; then
  cd vendor/
  git clone https://github.com/oh-my-fish/oh-my-fish
  cd oh-my-fish
  bin/install --offline
  cd $current_dir
fi

###
# AWS CLI
# TODO: this should probably be our own aliases file
###
current_dir=$(pwd)
if [[ ! -d 'vendor/awscli-aliases' ]]; then
    git clone https://github.com/awslabs/awscli-aliases.git vendor/awscli-aliases
fi
(cd vendor/awscli-aliases && git pull --ff-only)
mkdir -p ~/.aws/cli
cp vendor/awscli-aliases/alias ~/.aws/cli/alias

# Remove outdated versions from the cellar.
echo "=== Clean Homebrew ==="
brew cleanup
