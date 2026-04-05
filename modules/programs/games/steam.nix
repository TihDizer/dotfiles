{ ... }:
{
  flake.modules.nixos.programs-games-steam =
    { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        gamescopeSession.enable = true;
      };

      hardware.steam-hardware.enable = true;
      hardware.graphics.enable = true;
      hardware.graphics.enable32Bit = true;

      environment.systemPackages = with pkgs; [
        vulkan-loader
        vulkan-validation-layers
        mangohud
        gamescope
        mesa-demos # glxinfo, glxgears
        vulkan-tools # vulkaninfo
      ];

      services.speechd.enable = false;
    };
}
