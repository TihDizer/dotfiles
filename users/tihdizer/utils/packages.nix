{ ... }:
{
  flake.modules.homeManager.tihdizer-utils-packages =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        fastfetch # System info display

      ];

      programs.btop = {
        enable = true;
        package = pkgs.btop.override {
          # cudaSupport = true;   # NVIDIA
          rocmSupport = true; # AMD
        };
      };
    };
}
