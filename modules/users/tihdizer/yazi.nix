{ ... }:
{
  flake.modules.homeManager.tihdizer-yazi =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        yazi # Terminal file manager
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
