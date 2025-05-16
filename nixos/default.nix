{ nixosHost, ... }: {
  networking.hostName = nixosHost.hostName;

  services.openssh.enable = true;
  time.timeZone = "Europe/Berlin";

  system.stateVersion = "24.05";
}

