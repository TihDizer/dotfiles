{ inputs, ... }:
{
  flake.modules.nixos.programs-desktop-niri = {
    imports = with inputs.self.modules.nixos; [
      programs-desktop-niri-dbus
      programs-desktop-niri-session-manager
      programs-desktop-niri-env
    ];
  };
}
