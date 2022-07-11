#!/usr/bin/env just --justfile

emacs := "emacs28"

_default:
    @just --list --unsorted
#Install asdf tools listed in .tools-versions
install-tools:
    #!/bin/bash
    ! cut -d' ' -f1 .tool-versions|xargs -I{} asdf plugin add {}
    asdf install
    cat .tool-versions | xargs -n2 bash -c 'asdf global $0 $1'

install-apt: install-emacs-apt 
    #!/bin/bash
    sudo apt-get install fzf

install-emacs-apt:
    #!/bin/bash
    sudo apt remove --autoremove emacs
    sudo add-apt-repository ppa:kelleyk/emacs
    sudo apt update
    sudo apt install {{emacs}}

    ln -s configs/emacs ~/.config/emacs

uninstall-emacs-apt:
    #!/bin/bash
    sudo add-apt-repository --remove ppa:kelleyk/emacs
    sudo apt remove --autoremove {{emacs}} {{emacs}}-common

setup-bash:
    #!/bin/bash
    if ! grep -Fxq 'source ~/.workstation/configs/.bashrc' ~/.bashrc
    then
        echo 'source ~/.workstation/configs/.bashrc' >> ~/.bashrc
        echo 'Bashrc setup completed'
    else
        echo 'Bashrc already setup'
    fi
