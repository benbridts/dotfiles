#!/usr/bin/env bash
set -euf  -o pipefail
echo "=== starting installation ==="
source settings.sh

# Make sure we are signed in to the apple store
if ! mas account >/dev/null; then
  echo "Please sign in to the AppStore" >&2
  exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew.
set +e
which brew >/dev/null 2>&1
status=$?
set -e
if [[ $status -ne 0 ]]; then
  echo "=== Installing Homebrew ==="
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

###
# Homebrew
###
# HOMEBREW_GITHUB_API_TOKEN might not be exported
export HOMEBREW_GITHUB_API_TOKEN

echo "=== Update & Upgrade Homebrew ==="
# Make sure we’re using the latest Homebrew.
brew update
# Upgrade any already-installed formulae.
brew upgrade

###
# Software that doesn't need anything special
###
echo "=== Install from Homebrew ==="
echo "this might take some time, go take a break if this is a clean install"
brew bundle install --no-lock --verbose


###
# Pip
###
echo "=== Install from pip ==="
echo "this might also take some time, go take a second break if this is a clean install"
# only use pip for things that cannot run inside a virtualenv

# everything else with pipx
while read -r line
do
  # we ignore errors, they probably are caused by the packages already being installed
  # Hopefully the upgrade-all later will fail in other cases
  pipx install $line || true
done < pipx-packages.txt

# some pipx packages need to be in the same environment
pipx inject cloudformation-cli \
  cloudformation-cli-python-plugin \
  cloudformation-cli-java-plugin
pipx inject mypy mypy-extensions
pipx inject httpie \
  httpie-aws-authv4 \
  httpie-image
pipx inject cfn-lint pygraphviz

# upgrade all
# If python was updated, run "pipx uninstall-all" to remove all packages
pipx upgrade-all


###
# npm
##
npm install -g serverless
npm install -g cloudformation-graph
npm install -g aws-sam-local
npm install -g @mhlabs/cfn-diagram

###
# Rust
###
rustup-init -y

# Remove outdated versions from the cellar.
echo "=== Clean Homebrew ==="
brew cleanup
