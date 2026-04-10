{ ... }:
{
  flake.modules.homeManager.tihdizer-utils-archives =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Archives
        zip # ZIP archiver
        unzip # ZIP extractor
        arj # ARJ archiver
        rar # RAR extractor
        # unrar # RAR extractor
        p7zip # 7-Zip archiver
        # _7zz-rar # 7-Zip RAR handler
        # _7zz # 7-Zip CLI (p7zip alternative)
      ];
    };
}
