{ ... }:
{
  flake.modules.nixos.programs-desktop-appimage =
    { pkgs, ... }:
    {
      # AppImage
      programs.appimage = {
        enable = true;
        binfmt = true;
        package = pkgs.appimage-run.override {
          extraPkgs = pkgs: [ pkgs.libepoxy ];
        };
      };
    };
}
