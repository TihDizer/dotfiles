{
  pkgs,
  ...
}:

{
  # Logitech G102
  services.ratbagd.enable = true;

  environment.systemPackages = with pkgs; [
    piper # Logitech control panel
    libratbag # Logitech ratbag daemon
  ];
}
