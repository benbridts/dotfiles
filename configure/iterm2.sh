#! /bin/bash
# load preferences fro; a folder
defaults write com.googlecode.iterm2 PrefsCustomFolder -string  "${HOME}/.config/ben/iterm2";
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true