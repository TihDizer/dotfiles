{ ... }:
{
  flake.modules.homeManager.tihdizer-shell-zsh =
    { ... }:
    {
      programs.zsh.initContent = lib.mkAfter ''
        ZLE_RPROMPT_INDENT=0
      '';
    };
}
