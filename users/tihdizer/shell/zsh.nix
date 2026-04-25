{ ... }:
{
  flake.modules.homeManager.tihdizer-zsh =
    {
      lib,
      ...
    }:
    {
      programs.zsh.initContent = lib.mkAfter ''
        ZLE_RPROMPT_INDENT=0
      '';
    };
}
