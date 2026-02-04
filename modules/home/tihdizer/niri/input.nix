{
  programs.niri.settings.input = {
    #= Keyboard
    keyboard = {
      xkb = {
        layout = "us,ru";
        options = "grp:ctrl_shift_toggle";
      };
      numlock = true;
      repeat-delay = 500;
      repeat-rate = 30;
      track-layout = "window";
    };
    #= Mouse
    mouse = {
      enable = true;
      accel-profile = "flat";
      scroll-factor = 1.0;
    };
    focus-follows-mouse.enable = false;
    warp-mouse-to-focus.enable = true;
    workspace-auto-back-and-forth = true;
  };
}
