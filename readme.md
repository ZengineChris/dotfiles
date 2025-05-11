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


