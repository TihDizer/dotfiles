{ ... }:
{
  flake.modules.nixos.archives =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ouch # Painless compression and decompression in the terminal
        rar # RAR extractor
      ];
    };

  flake.modules.homeManager.archives =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ouch # Painless compression and decompression in the terminal
        rar # RAR extractor
      ];
    };
}
