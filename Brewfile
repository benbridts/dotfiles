# Generate with
# brew bundle dump --describe --file=tmp.Brewfile
# and move things to the right brewfile 

tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-drivers"
tap "homebrew/cask-fonts"
tap "homebrew/cask-versions"
tap "homebrew/core"
tap "homebrew/services"

def include_brew(f)
    instance_eval(File.read(File.join("brew", f)))
end

include_brew "av.Brewfile"
include_brew "aws.Brewfile"
include_brew "core.Brewfile"
include_brew "docker.Brewfile"
include_brew "go.Brewfile"
include_brew "java.Brewfile"
include_brew "javascript.Brewfile"
include_brew "python.Brewfile"
include_brew "ruby.Brewfile"
include_brew "rust.Brewfile"
include_brew "work.Brewfile"
