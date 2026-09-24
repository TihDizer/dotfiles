{ ... }:
{
  flake.modules.homeManager.nix =
    { pkgs, ... }:
    {
      # Nix tooling
      home.packages = with pkgs; [
        # Core
        nixfmt # nix fmt
        nixd # Nix LSP

        # Utils
        comma
        nix-diff
        nix-tree
        nix-du
        nix-init

        # Advanced
        statix # linter
        deadnix # unused vars
      ];
    };
}
