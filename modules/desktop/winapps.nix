{
  pkgs,
  winapps,
  system ? pkgs.system,
  ...
}:

{
  environment.systemPackages = [
    winapps.packages.${system}.winapps
    winapps.packages.${system}.winapps-launcher # optional
  ];
}
