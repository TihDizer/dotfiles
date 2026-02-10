{
  nix = {
    settings = {
      cores = 4;
      max-jobs = 2;
      substituters = [ "https://cache.nixos.org/" ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      keep-derivations = false;
      keep-outputs = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d --delete-generations +3";
    };
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
