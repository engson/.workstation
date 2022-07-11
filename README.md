# .workstation

Setup of workstation on a linux machine. Includes dotfiles and binary setups

## Installation

Recommended to install binaries first.
Pre-reqs: [asdf](https://asdf-vm.com/guide/getting-started.html)
`asdf update` to update asdf

```sh
# Install just 
asdf plugin add just

asdf install just latest
asdf global just latest

# update plugins
asdf plugin update --all
```

### binaries

Install tools listed in .tool-versions
`just install-tools`

### dotfiles
