{
  pkgs,
  ...
}:

{
  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wiremix
    pwvucontrol
    playerctl
  ];
}
