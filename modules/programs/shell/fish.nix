{ ... }:
{
  flake.modules.nixos.programs-shell-fish =
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
