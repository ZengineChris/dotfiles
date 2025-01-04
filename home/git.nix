{
  config,
  pkgs,
  ...
}: {
  enable = true;
  lfs.enable = true;
  userName = "ZengineChris";
  userEmail = "zengineChris@gmail.com";
  delta = {
    enable = true;
  };
  extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
  };
}
