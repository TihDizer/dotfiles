# ./home/tihdizer/dev/nix/default.nix
{ pkgs, ... }:

{
  # Nix tooling
  home.packages = with pkgs; [
    # Core
    nixfmt # nix fmt
    nil # Nix LSP (zed/vscode)
    nixpkgs-fmt # alejandra альтернатива

    # Utils
    nix-diff # сравнение генераций
    nix-tree # дерево зависимостей
    nix-du # размер store
    nix-init # flake.nix generator

    # Advanced
    statix # linter
    deadnix # unused vars
  ];

  # Shell integrations
  programs.bash.shellAliases = {
    nr = "nix run nixpkgs#";
    ns = "nix shell nixpkgs#";
    nf = "nix flake";
  };

  programs.zsh.initExtra = ''
    nr() { nix run nixpkgs#$@; }
    ns() { nix shell nixpkgs#$@; }
  '';
}
