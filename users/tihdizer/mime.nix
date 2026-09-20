{ ... }:
{
  flake.modules.homeManager.tihdizer-mime =
    { ... }:
    let
      officeMimeTypes = [
        # Word documents
        "application/msword"
        "application/vnd.ms-word"
        "application/x-msword"
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        "application/vnd.openxmlformats-officedocument.wordprocessingml.template"
        "application/vnd.oasis.opendocument.text"

        # Spreadsheets
        "application/vnd.ms-excel"
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        "application/vnd.oasis.opendocument.spreadsheet"

        # Presentations
        "application/vnd.ms-powerpoint"
        "application/vnd.openxmlformats-officedocument.presentationml.presentation"
        "application/vnd.oasis.opendocument.presentation"
      ];

      officeAssociations = builtins.listToAttrs (
        map (mime: {
          name = mime;
          value = [ "onlyoffice-desktopeditors.desktop" ];
        }) officeMimeTypes
      );
    in
    {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = officeAssociations;
      };
    };
}
