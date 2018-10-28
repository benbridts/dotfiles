#! /bin/bash
fish_path=$(which fish)
default_shell=$(dscl . -read ${HOME} UserShell | sed 's/UserShell: //')

if ! grep "${fish_path}" /etc/shells >/dev/null ; then
  echo "${fish_path}" | sudo tee -a /etc/shells
fi

if [[ "${default_shell}" != ${fish_path} ]]; then
  # Default shell
  chsh -s $(which fish)
fi

gsed -i s/__HOMEBREW_GITHUB_API_TOKEN__/${HOMEBREW_GITHUB_API_TOKEN}/ ~/.config/fish/config.fish