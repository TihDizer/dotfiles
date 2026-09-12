{ ... }:
{
  flake.modules.homeManager.tihdizer-userdirs =
    { config, ... }:
    {
      xdg.userDirs = {
        enable = true;
        desktop = "";
        download = "$HOME/downloads";
        documents = "$HOME/documents";
        music = "$HOME/medias/music";
        pictures = "$HOME/medias/pictures";
        videos = "$HOME/medias/videos";
        templates = "$HOME/documents/templates";
        publicShare = "$HOME/shared";
      };

      home.file."mnt/usbs".source = config.lib.file.mkOutOfStoreSymlink "/run/media/tihdizer";

      # Archive HDD RAID1
      home.file."mnt/archive".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer";
      home.file."downloads".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/downloads";
      home.file."notes".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/notes";
      home.file."documents".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/documents";
      home.file."medias".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/medias";
      home.file."shared/archive".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/shared";
      home.file."games/archive".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/games";
      home.file."vms/archive".source = config.lib.file.mkOutOfStoreSymlink "/mnt/archive/tihdizer/vms";

      # Fast SATA SSD RAID0
      home.file."mnt/ssd".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd/tihdizer";
      home.file."shared/ssd".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd/shared";
      home.file."games/ssd".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd/tihdizer/games";
      home.file."vms/ssd".source = config.lib.file.mkOutOfStoreSymlink "/mnt/ssd/tihdizer/vms";
    };
}
