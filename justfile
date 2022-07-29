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

install: setup-bash install-tools
    #!/bin/bash
    if command -v apt-get >/dev/null; then
        just install-apt
    elif command -v yum >/dev/null; then
        echo "yum is used here"
    else
        echo "I have no Idea what im doing here"
    fi

uninstall:
    #!/bin/bash
    if command -v apt-get >/dev/null; then
        just uninstall-apt
    elif command -v yum >/dev/null; then
        echo "yum is used here"
    else
        echo "I have no Idea what im doing here"
    fi

install-apt: install-emacs-apt 
    #!/bin/bash
    sudo apt-get install fzf

install-emacs-apt:
    #!/bin/bash
    sudo apt remove --autoremove emacs
    sudo add-apt-repository ppa:kelleyk/emacs
    sudo apt update
    sudo apt install {{emacs}}

    ln -sfv {{justfile_directory()}}/configs/emacs ~/.config/emacs

uninstall-apt: uninstall-emacs-apt
    echo "Uninstall apt successfull"

uninstall-emacs-apt:
    #!/bin/bash
    sudo add-apt-repository --remove ppa:kelleyk/emacs
    sudo apt remove --autoremove {{emacs}} {{emacs}}-common

setup-bash:
    #!/bin/bash
    if ! grep -Fxq 'source {{justfile_directory()}}/configs/.bashrc' ~/.bashrc
    then
        echo 'source {{justfile_directory()}}/configs/.bashrc' >> ~/.bashrc
        echo 'Bashrc setup completed'
    else
        echo 'Bashrc already setup'
    fi

debug:
    #!/bin/bash
    echo "dir {{justfile_directory()}}"
    echo "os {{os()}}"
    echo "arch {{arch()}}"
