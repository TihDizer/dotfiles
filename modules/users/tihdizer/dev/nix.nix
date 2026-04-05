{ ... }:
{
  flake.modules.homeManager.hm-tihdizer-dev-nix =
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

      # # Shell integrations
      # programs.bash.shellAliases = {
      #   nr = "nix run nixpkgs#";
      #   ns = "nix shell nixpkgs#";
      #   nf = "nix flake";
      # };

      # programs.zsh.initExtra = ''
      #   nr() { nix run nixpkgs#$@; }
      #   ns() { nix shell nixpkgs#$@; }
      # '';
    };
}
