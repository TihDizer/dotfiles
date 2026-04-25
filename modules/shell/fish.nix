{ ... }:
{
  flake.modules.nixos.fish =
    { ... }:
    {
      programs.fish = {
        enable = true;
        generateCompletions = true;
        shellAbbrs = {
        };
        # TODO: move in starship
        interactiveShellInit = "
          function fish_greeting
            starship init fish | source
          end
        ";
      };
    };

  flake.modules.homeManager.fish =
    { ... }:
    {
      programs.fish = {
        enable = true;
        generateCompletions = true;
        shellAbbrs = {
        };
        # TODO: move in starship
        interactiveShellInit = "
          function fish_greeting
            starship init fish | source
          end
        ";
      };
    };
}
