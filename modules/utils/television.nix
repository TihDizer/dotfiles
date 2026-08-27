{ ... }:
{
  flake.modules.homeManager.television =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        television
        ripgrep
        fd
      ];
    };
}
