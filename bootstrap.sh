#!/usr/bin/env bash
# based on https://github.com/mathiasbynens/dotfiles/blob/master/bootstrap.sh

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
  ./macos.sh
  ./install.sh

  rsync --exclude ".git/" \
    --exclude ".gitignore" \
    --exclude "vendor/" \
    --exclude ".DS_Store" \
    --exclude "*.sh" \
    --exclude "*.md" \
    --exclude "LICENSE-MIT.txt" \
    -avh --no-perms . ~;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset doIt;
