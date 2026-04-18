{ ... }:
{
  flake.modules.nixos.utils-archives =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ouch # Painless compression and decompression in the terminal
        zip # ZIP archiver
        unzip # ZIP extractor
        arj # ARJ archiver
        rar # RAR extractor
        p7zip # 7-Zip archiver
      ];
    };

  flake.modules.homeManager.utils-archives =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ouch # Painless compression and decompression in the terminal
        zip # ZIP archiver
        unzip # ZIP extractor
        arj # ARJ archiver
        rar # RAR extractor
        p7zip # 7-Zip archiver
      ];
    };
}
