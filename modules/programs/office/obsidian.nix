{ ... }:
{
  flake.modules.homeManager.programs-obsidian =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        obsidian # Markdown note app
      ];
    };
}
