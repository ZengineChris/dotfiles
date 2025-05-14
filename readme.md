# Dotfiles

## Installation 
First of all install the nix packge manager.
```shell
sh <(curl -L https://nixos.org/nix/install)
```


# Install the Flake 

```bash
# If you are deploying for the first time,
# 1. install nix & homebrew manually.
# 2. prepare the deployment environment with essential packages available
nix-shell -p just nushell

# 3. deploy configuration
just update 

# deploy with details
just update debug
```

