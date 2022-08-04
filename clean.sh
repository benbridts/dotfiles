#!/bin/bash
set -ex

docker system prune
brew cleanup -s --prune=all
go clean -cache -modcache
npm cache clean --force
yarn cache clean --force

for v in $(pyenv versions | grep 3. | sort -Vr | tail -n+2); do
    pyenv uninstall -f $v
done
# vagrant box prune
# vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f
rm -rf ~/Library/Caches/pipenv/*
rm -rf ~/.local/share/virtualenvs/*
rm -rf ~/.cache/*
rm -rf ~/.gradle/caches

find ~/src -type d -path '*/.aws-sam/build' -print -exec rm -rf \{\} +
find ~/src -type d -name '.venv' -print -exec rm -rf \{\} +

echo "done"
