{ inputs, ... }:
{
  flake-file.inputs = {
    yazi.url = "github:sxyazi/yazi";
  };

  flake.modules.homeManager.programs-yazi =
    { pkgs, ... }:
    {
      nix = {
        settings = {
          extra-substituters = [
            "https://yazi.cachix.org"
          ];
          extra-trusted-public-keys = [
            "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
          ];
        };
      };

      programs.yazi = {
        enable = true;
        package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };

      home.packages = with pkgs; [
        ouch # Painless compression and decompression in the terminal
        poppler # PDF rendering library
        fd # Fast find alternative
        file # File type detector
        jq # JSON processor
        ripgrep # Fast grep (rg)
        fzf # Fuzzy finder
        zoxide # Smart cd (z)
        resvg # SVG rasterizer
        imagemagick # Image manipulation
        bat # Cat clone with syntax highlighting
        atuin # Shell history search (atuin)
        lsd # Modern ls alternative
      ];
    };
}
