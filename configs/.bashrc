# Extension of bashrc

## Custom functions
function gititup() {
  git add .
  git commit -a -s -m "$1"
  git push
}

export PATH="/opt/:$PATH"

alias ripgrep="rg"
