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
        interactiveShellInit = "
          function fish_greeting
            fastfetch
          end
        ";
      };
    };
}
