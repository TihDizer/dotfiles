{ ... }:
{
  flake.modules.nixos.programs-games-prism-launcher =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        (prismlauncher.override {
          # Add binary required by some mod
          additionalPrograms = [ ffmpeg ];

          # Change Java runtimes available to Prism Launcher
          jdks = [
            zulu8
            zulu17
            zulu
          ];
        })
      ];
    };
}
