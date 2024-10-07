{ config, pkgs, ... }:
{
  enable = true;
  lfs.enable = true;
  userName = "ZengineChris";
  userEmail = "zengineChris@gmail.com";
  #signing.key = null;
  #signing.signByDefault = true;

  extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
  };
}
