{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # easyeffects # Audio effects tool
    # qpwgraph # PipeWire patchbay GUI
    pavucontrol # PulseAudio control GUI
  ];
}
