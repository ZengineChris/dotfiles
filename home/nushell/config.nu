mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

let carapace_completer = {|spans|
    carapace $spans.0 nushell ...$spans | from json
}

$env.config = {
     show_banner: false,
     completions: {
     case_sensitive: false # case-sensitive completions
     quick: true    # set to false to prevent auto-selecting completions
     partial: true    # set to false to prevent partial filling of the prompt
     algorithm: "fuzzy"    # prefix or fuzzy
     external: {
     # set to false to prevent nushell looking into $env.PATH to find more suggestions
         enable: true
     # set to lower can improve completion performance at the cost of omitting some options
         max_results: 100
         completer: $carapace_completer # check 'carapace_completer'
       }
     }
    hooks: {
        pre_prompt: [{ ||
            if (which direnv | is-empty) {
        return
      }

      direnv export json | from json | default {} | load-env
    }]
  }
}

$env.PATH = ($env.PATH |
    split row (char esep) |
    prepend /home/christian/.apps |
    append /usr/bin/env
)

$env.EDITOR = 'nvim';
$env.KUBE_EDITOR = 'nvim';

alias nerdclt = lima nerdctl;
alias k = kubectl;
alias update = nix flake update ~/github.com/zengineChris/dotfiles/darwin;
alias switch = darwin-rebuild switch --flake ~/github.com/zengineChris/dotfiles/darwin;
alias v = nvim;

def update-docker-secret [
    namespace: string,  # Kubernetes namespace
    github_token: string  # GitHub Personal Access Token
] {
    let docker_config = {
        auths: {
            "ghcr.io": {
                "username": "token",
                "password": $github_token,
                "auth": ($"token:$github_token" | encode base64)
            }
        }
    } | to json

    let encoded_config = $docker_config | encode base64

    kubectl delete secret regcred -n $namespace | ignore
    kubectl create secret generic regcred --from-literal=.dockerconfigjson=$encoded_config --type=kubernetes.io/dockerconfigjson -n $namespace
}


mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
