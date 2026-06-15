{ ... }:
let
  sharedAliases = {
    find = "fd";
    grep = "rg";
    df = "duf";
    du = "dust";
    ping = "gping";
    curl = "http";

    ls = "eza --icons --group-directories-first";
    ll = "eza -lbGh --icons --git --group-directories-first";
    la = "eza -lbghia --icons --git --group-directories-first";
    cat = "bat --style=plain";
  };

  sharedPackages =
    pkgs: with pkgs; [
      eza # replacement for ls
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
