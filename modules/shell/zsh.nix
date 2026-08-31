{ ... }:
{
  flake.modules.nixos.zsh =
    { ... }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
      };
    };

  flake.modules.homeManager.zsh =
    { ... }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        historySubstringSearch.enable = true;
      };
    };
}
