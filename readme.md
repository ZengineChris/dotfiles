# Dotfiles

The new appoach is to install and manage all the os tools with nix. 


First of all install the nix packge manager.


```shell
sh <(curl -L https://nixos.org/nix/install)
```

Install the profile 

```shell
cd nix && nix profile install .
```



```shell
$ echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
$ chsh -s /opt/homebrew/bin/fish
```

## Tools 
```shell
brew install lua
brew install yabai
brew install skhd
brew install nvim
brew install spacebar
brew install tmux
brew install starship
brew install fish
brew install stow
brew install exa
```

## Languages and coding tools 
```shell
brew install --cask anaconda
brew install go
```


### TODO 
- [ ] Folder Setup for mac and Linux
- [ ] Add settings for kitty 
- [ ] Switch to zsh and omyzsh 
- [ ] make some ansible script to install all the things 
- [ ] rework on the nvim config 
