export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CASK_OPTS=--require-sha

export GOPATH="$HOME/Documents/golang"
export GOROOT="/usr/local/opt/go/libexec"

if (( $+commands[brew] )); then
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi

if (( $+commands[gcloud] )); then
  GCPREFIX="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
  source $GCPREFIX/path.zsh.inc
  source $GCPREFIX/completion.zsh.inc
fi

if (( $+commands[terraform] )); then
  TF_VERSION=$(terraform --version | head -n 1 | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/')
  complete -o nospace -C \
    "/usr/local/Cellar/terraform/$TF_VERSION/bin/terraform" terraform
fi