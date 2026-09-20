{ ... }:
{
  flake.modules.homeManager.tihdizer-userdirs =
    { config, ... }:
    {
      xdg.userDirs = {
        enable = true;
        desktop = "$HOME/desktop";
        download = "$HOME/downloads";
        documents = "$HOME/documents";
        music = "$HOME/music";
        pictures = "$HOME/pictures";
        videos = "$HOME/videos";
        templates = "$HOME/templates";
        publicShare = "$HOME/shared";
      };

      home.file."mnt/usbs".source = config.lib.file.mkOutOfStoreSymlink "/run/media/tihdizer";

      # Archive HDD RAID1
      home.file."mnt/archive".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer";
      home.file."downloads".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/downloads";
      home.file."notes".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/notes";
      home.file."documents".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/documents";
      home.file."screenshots".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/screenshots";
      home.file."shared/archive".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/shared";
      home.file."games/archive".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/games";
      home.file."vms/archive".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/vms";
      home.file."desktop".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/desktop";
      home.file."music".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/music";
      home.file."pictures".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/pictures";
      home.file."videos".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/videos";
      home.file."templates".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/templates";

      # Fast SATA SSD RAID0
      home.file."mnt/ssd".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd/tihdizer";
      home.file."shared/ssd".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd/shared";
      home.file."games/ssd".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd/tihdizer/games";
      home.file."vms/ssd".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd/tihdizer/vms";
    };
}
