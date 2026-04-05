{ ... }:
{
  flake.modules.homeManager.hm-tihdizer-web-chrome =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        google-chrome # Web browser
      ];
    };
}
