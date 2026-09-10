{ lib, ... }:
let
  templatesDir = ../../templates;
  entries = builtins.readDir templatesDir;
  
  # Only collect subdirectories, ignoring standalone files like module-template.nix
  templateDirs = lib.filterAttrs (name: type: type == "directory") entries;

  mkTemplate = name: {
    path = templatesDir + "/${name}";
    description = "${name} template";
  };
in
{
  flake.templates = lib.mapAttrs (name: _: mkTemplate name) templateDirs;
}
