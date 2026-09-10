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
        wireplumber.extraConfig."50-rename-hd-audio" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {
                  "device.name" = "alsa_card.pci-0000_30_00.6";
                }
              ];
              actions = {
                update-props = {
                  "device.description" = "Realtek ALC897 Audio";
                  "device.nick" = "Realtek ALC897";
                };
              };
            }
            {
              matches = [
                {
                  "node.name" = "alsa_output.pci-0000_30_00.6.analog-stereo";
                }
              ];
              actions = {
                update-props = {
                  "node.description" = "Realtek ALC897 Analog Stereo";
                  "node.nick" = "Speakers / Headphones";
                };
              };
            }
            {
              matches = [
                {
                  "node.name" = "alsa_input.pci-0000_30_00.6.analog-stereo";
                }
              ];
              actions = {
                update-props = {
                  "node.description" = "Realtek ALC897 Microphone";
                  "node.nick" = "Microphone";
                };
              };
            }
            {
              matches = [
                {
                  "device.name" = "alsa_card.pci-0000_30_00.1";
                }
              ];
              actions = {
                update-props = {
                  "device.description" = "AMD Cezanne HDMI/DP Audio";
                  "device.nick" = "Cezanne HDMI";
                };
              };
            }
            {
              matches = [
                {
                  "node.name" = "alsa_output.pci-0000_30_00.1.hdmi-stereo";
                }
              ];
              actions = {
                update-props = {
                  "node.description" = "AMD Cezanne HDMI/DP Audio Digital Stereo (HDMI)";
                  "node.nick" = "Cezanne HDMI";
                };
              };
            }
          ];
        };
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
