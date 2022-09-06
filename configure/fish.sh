#! /bin/bash

# Get some info
fish_path=$(which fish)
default_shell=$(dscl . -read ${HOME} UserShell | sed 's/UserShell: //')

# Add fish as an available shell
if ! grep "${fish_path}" /etc/shells >/dev/null ; then
  echo "${fish_path}" | sudo tee -a /etc/shells
fi

# Change the default shell to fish
if [[ "${default_shell}" != ${fish_path} ]]; then
  # Default shell
  chsh -s $(which fish)
fi

# Configuration of fish
# Add our own things to the path:
# - .cargo/bin is used by rust
# - .local/bin is used by pipx
fish -c "set -u fish_user_paths ${HOME}/.cargo/bin ${HOME}/.local/bin"

# Add completions
mkdir -p ${HOME}/.config/fish/completions
# - pipx
register-python-argcomplete --shell fish pipx > ${HOME}/.config/fish/completions/pipx.fish
# - gh
gh completion -s fish > ${HOME}/.config/fish/completions/gh.fish

mkdir -p ${HOME}/.config/fish/conf.d
# Install shell integrations for iterm
curl -L https://iterm2.com/shell_integration/fish \
  -o $HOME/.config/fish/conf.d/zzz_iterm2_shell_integration.fish

# Install OMF
fish -c 'omf --version' || ( curl -L https://get.oh-my.fish | NONINTERACTIVE='' fish )
# update OMF
fish -c 'omf update'
# install things with omf
fish -c 'omf install bobthefish aws'
fish -c 'omf theme bobthefish'
# git completions
fish -c 'omf install https://github.com/jhillyerd/plugin-git'
# faster thefuck integration
fish -c 'omf install thefuck'
# weather
fish -c 'omf install weather'
fish -c 'omf reload'  # https://github.com/oh-my-fish/plugin-weather/issues/38
fish -c "config weather --set api-key ${OPENWEATHERMAP_API_TOKEN}"  # https://home.openweathermap.org/api_keys
