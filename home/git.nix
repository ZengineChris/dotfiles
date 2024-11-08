{ config, pkgs, ... }:
{
  enable = true;
  lfs.enable = true;
  userName = "ZengineChris";
  userEmail = "zengineChris@gmail.com";

  extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
  };
}
