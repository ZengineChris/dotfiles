{ pkgs }: {
  config = {
    environment.systemPackages = [
        pkgs.deno
    ];
  };
}
