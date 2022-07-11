#!/usr/bin/env just --justfile

_default:
    @just --list --unsorted
#Install asdf tools listed in .tools-versions
install-tools:
    #!/bin/bash
    ! cut -d' ' -f1 .tool-versions|xargs -I{} asdf plugin add {}
    asdf install
    cat .tool-versions | xargs -n2 bash -c 'asdf global $0 $1'
