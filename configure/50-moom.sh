#!/bin/bash

# source settings - so this can also be used standalone
source settings.sh

mkdir -p ~/Library/Application\ Support/Many\ Tricks/Licenses/
echo $MOOM_LICENCES_BASE64 | base64 --decode > ~/Library/Application\ Support/Many\ Tricks/Licenses/dotfiles.moomlicense

# Moom needs to ask for their own permissions
# And to be started at least once, because we downloaded it from the internet
open /Applications/Moom.app
