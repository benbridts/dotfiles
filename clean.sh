#!/bin/bash
set -ex
echo "Current disk usage"
df -h
echo "Starting clean"
docker system prune
brew cleanup -s --prune=all
go clean -cache -modcache
npm cache clean --force
yarn cache clean --force

# remove almost all pyenvs
for v in $(pyenv versions | grep 3. | sort -Vr | tail -n+2); do
    pyenv uninstall -f $v
done
# vagrant box prune
# vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f

# remove pipenv caches
rm -rf ~/Library/Caches/pipenv/*
# remove pipenv (central) virtualenvs
rm -rf ~/.local/share/virtualenvs/*
# remove poetry *central) virtualenvs and caches
rm -rf ~/ben/Library/Caches/pypoetry/*
rm -rf ~/.cache/*
rm -rf ~/.gradle/caches

find ~/src -type d -path '*/.aws-sam/build' -print -exec rm -rf \{\} +
find ~/src -type d -name '.venv' -print -exec rm -rf \{\} +
find ~/src -type d -name 'venv' -print -exec rm -rf \{\} +

echo "done"
echo "Current disk usage"
df -h
