set -gx LC_ALL en_US.UTF-8

set -gx HOMEBREW_GITHUB_API_TOKEN __HOMEBREW_GITHUB_API_TOKEN__

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish

# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish

thefuck --alias | source

alias aws-profile="aws-vault list --profiles | grep --color"
set -g fish_user_paths "/usr/local/opt/mysql-client/bin" $fish_user_paths
