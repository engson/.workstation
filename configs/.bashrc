# Extension of bashrc

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/engson/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/engson/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/engson/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/engson/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Asdf installation
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

#Cargo
. "$HOME/.cargo/env"

## Custom functions
function gititup() {
  git add .
  git commit -a -s -m "$1"
  git push
}


## fzf auto-completion
source /usr/share/doc/fzf/examples/key-bindings.bash

## Android studio
export ANDROID_HOME=${HOME}/Android/Sdk
export PATH="${ANDROID_HOME}/tools:${PATH}"
export PATH="${ANDROID_HOME}/emulator:${PATH}"
export PATH="${ANDROID_HOME}/platform-tools:${PATH}"
export PATH="/opt/:$PATH"

##emacs
alias emacs='emacs -nw'
