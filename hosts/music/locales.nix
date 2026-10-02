{ ... }:
{
  flake.modules.nixos.music-locales =
    { ... }:
    {
      i18n = {
        defaultLocale = "en_US.UTF-8";
      };

      time.timeZone = "Europe/Moscow";
    };
}
