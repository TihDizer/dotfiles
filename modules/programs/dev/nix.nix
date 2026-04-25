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
        nil # Nix LSP
        nixpkgs-fmt

        # Utils
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
