#!/bin/bash
set -ex

docker system prune
brew cleanup -s --prune=all
go clean -cache -modcache
npm cache clean --force
yarn cache clean --force
# vagrant box prune
# vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f
rm -rf ~/Library/Caches/pipenv/*
rm -rf ~/.local/share/virtualenvs/*
rm -rf ~/.cache/*

echo "done"
