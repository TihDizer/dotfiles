{ ... }:
{
  flake.modules.nixos.system-audio =
    { pkgs, ... }:
    {
      # Audio
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        extraConfig.pipewire."10-virtual-cable" = {
          "context.objects" = [
            {
              factory = "adapter";
              args = {
                "factory.name" = "support.null-audio-sink";
                "node.name" = "Virtual_Sink";
                "node.description" = "Virtual Sink";
                "media.class" = "Audio/Sink";
                "audio.position" = [
                  "FL"
                  "FR"
                ];
              };
            }
          ];
        };
      };

      security.rtkit.enable = true;

      environment.systemPackages = with pkgs; [
        wiremix
        pwvucontrol
        qpwgraph
        playerctl
      ];
    };
}
