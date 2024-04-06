{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    unstable.url = "nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv/latest";
  };

  outputs = { self, nixpkgs, unstable, devenv }: {
    packages."aarch64-darwin".default =
      let
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        unstablePkgs = unstable.legacyPackages."aarch64-darwin";
      in
      pkgs.buildEnv {
        name = "dev-env";
        paths = with pkgs; [
          # general tools
          git
          tmux
          wget
          curl
          jq
          bat
          # ... add your tools here

        ];
      };
  };

}
