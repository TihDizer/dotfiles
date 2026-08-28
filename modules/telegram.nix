{ ... }:
{
  flake.modules.homeManager.telegram =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        telegram-desktop
      ];

      xdg.dataFile."TelegramDesktop/tdata/shortcuts-custom.json".text = builtins.toJSON [
        {
          command = "next_chat";
          keys = "ctrl+j";
        }
        {
          command = "previous_chat";
          keys = "ctrl+k";
        }

        {
          command = "previous_folder";
          keys = "ctrl+h";
        }
        {
          command = "next_folder";
          keys = "ctrl+l";
        }

        {
          command = "first_chat";
          keys = "ctrl+alt+k";
        }
        {
          command = "last_chat";
          keys = "ctrl+alt+j";
        }

        {
          command = "search";
          keys = "ctrl+f";
        }
        {
          command = "read_chat";
          keys = "ctrl+r";
        }
        {
          command = "archive_chat";
          keys = "ctrl+shift+a";
        }
        {
          command = "message_silently";
          keys = "ctrl+shift+s";
        }
        {
          command = "message_scheduled";
          keys = "ctrl+shift+m";
        }
        {
          command = "close_telegram";
          keys = "ctrl+w";
        }
        {
          command = "quit_telegram";
          keys = "ctrl+q";
        }

        {
          command = "show_contacts";
          keys = "ctrl+shift+c";
        }
        {
          command = "lock_telegram";
          keys = "ctrl+shift+l";
        }
      ];
    };
}
