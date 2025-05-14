# Dotfiles

The new appoach is to install and manage all the os tools with nix. 


First of all install the nix packge manager.


```shell
sh <(curl -L https://nixos.org/nix/install)
```

Install the profile 

```shell
darwin-rebuild switch --flake .
```

# Install the Flake 

```bash
# If you are deploying for the first time,
# 1. install nix & homebrew manually.
# 2. prepare the deployment environment with essential packages available
nix-shell -p just nushell
# 3. comment home-manager's code in lib/macosSystem.nix to speed up the first deployment.
# 4. comment out the proxy settings in scripts/darwin_set_proxy.py if the proxy is not ready yet.

# 4. deploy harmonica's configuration(macOS Intel)
just ha

# deploy fern's configuration(Apple Silicon)
just fe

# deploy with details
just ha debug
# just fe debug
```

