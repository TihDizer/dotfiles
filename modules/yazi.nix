{ inputs, ... }:
{
  flake-file.inputs = {
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.yazi =
    { pkgs, ... }:
    {
      programs.yazi = {
        enable = true;
        package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };

      home.packages = with pkgs; [
        ouch # Painless compression and decompression in the terminal
        jellyfin-ffmpeg
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
        ripdrag # Drag and drop utility
      ];
    };
}
