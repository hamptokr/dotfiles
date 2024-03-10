mise_update_golang_env() {
  local go_path
  go_path="$(mise which go)"
  if [[ -n "${go_path}" ]]; then
    export GOROOT
    GOROOT="$(dirname "$(dirname "${go_path:A}")")"

    export GOBIN
    GOBIN="$(dirname "$(dirname "${go_path:A}")")/bin"
  fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd mise_update_golang_env
