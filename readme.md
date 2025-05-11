# Dotfiles


## TODO 
Rebuild this to only for my mac to use 

For my work macBook I will use the work related flake so i dont need this one. 
The structure can be the same, but without any optional and user specific stuff. 
only for me. 





The new appoach is to install and manage all the os tools with nix. 


First of all install the nix packge manager.


```shell
sh <(curl -L https://nixos.org/nix/install)
```

Install the profile 

```shell
home-manager switch --flake .
```


