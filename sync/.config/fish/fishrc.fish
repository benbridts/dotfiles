# append ~/bin to path
set PATH $HOME/bin $PATH

# set the locale (aws fails otherwise)
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

# Include aws code completion

