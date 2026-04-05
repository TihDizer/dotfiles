{ ... }:
{
  flake.modules.homeManager.hm-tihdizer-home =
    { config, ... }:
    {
      home.username = "tihdizer";
      home.homeDirectory = "/home/tihdizer";
      home.stateVersion = "25.05";

      home.file.".hdd1" = {
        source = config.lib.file.mkOutOfStoreSymlink "/mnt/hdd1";
      };

      # home.file.".hdd2" = {
      #   source = config.lib.file.mkOutOfStoreSymlink "/mnt/hdd1"; # подставь /mnt/hdd2 когда настроишь
      # };

      home.file.".nvme" = {
        source = config.lib.file.mkOutOfStoreSymlink "/mnt/nvme";
      };
    };
}
