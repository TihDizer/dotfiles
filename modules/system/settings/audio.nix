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
      };

      security.rtkit.enable = true;

      environment.systemPackages = with pkgs; [
        wiremix
        pwvucontrol
        playerctl
      ];
    };
}
