{ ... }:
{
  flake.modules.nixos.host-main-locales =
    { ... }:
    {
      i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocales = [
          "ru_RU.UTF-8/UTF-8"
          "en_US.UTF-8/UTF-8"
        ];
        inputMethod = {
          enable = true;
          type = "fcitx5";
        };
      };

      time.timeZone = "Europe/Moscow";

      console.useXkbConfig = true;
      services.xserver.xkb = {
        layout = "us,ru";
        options = "grp:win_space_toggle";
      };
    };
}
