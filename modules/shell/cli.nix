{ ... }:
let
  sharedAliases = {
    ls = "lsd";
    e = "eza -lbGh --icons --git --group-directories-first";
    la = "eza -lbghia --icons --git --group-directories-first";
  };

  sharedPackages =
    pkgs: with pkgs; [
      lsd # replacement for ls
      eza # alternative for ls
      bat # replacement for cat
      zoxide # replacement for cd
      ripgrep # replacement for grep
      fd # replacement for find
      duf # replacement for df
      dust # replacement for du
      gping # replacement for ping
      httpie # replacement for curl
      tldr # replacement for man
    ];
in
{
  flake.modules.nixos.cli =
    { pkgs, ... }:
    {
      environment.systemPackages = sharedPackages pkgs;

      environment.shellAliases = sharedAliases;

      programs.zoxide = {
        enable = true;
      };
    };

  flake.modules.homeManager.cli =
    { pkgs, ... }:
    {
      home.packages = sharedPackages pkgs;

      home.shellAliases = sharedAliases;

      programs.zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
      };
    };
}
