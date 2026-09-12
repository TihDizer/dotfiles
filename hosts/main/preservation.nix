{ inputs, ... }:
{
  flake-file.inputs = {
    preservation = {
      url = "github:nix-community/preservation";
    };
  };

  flake.modules.nixos.host-main-preservation =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      imports = lib.optional (inputs ? preservation) inputs.preservation.nixosModules.preservation;

      config = lib.mkIf (options ? preservation) {
        preservation = {
          enable = lib.mkDefault true;
          preserveAt."/persistent" = {
            # Persistent system directories across all dotfiles modules
            directories = [
              "/var/log"
              "/var/lib/nixos"
              "/var/lib/systemd/coredump"
              "/var/lib/bluetooth"
              "/var/lib/sops-nix"
              "/var/lib/libvirt"
              "/var/lib/docker"
              "/var/lib/containers"
              "/var/lib/sunshine"
              "/var/lib/dae"
              "/etc/NetworkManager/system-connections"
              "/etc/ssh"
            ];

            # Persistent system files
            files = [
              {
                file = "/etc/machine-id";
                inInitrd = true;
                how = "symlink";
                configureParent = true;
              }
              {
                file = "/etc/passwd";
                inInitrd = true;
                how = "symlink";
                configureParent = true;
              }
              {
                file = "/etc/group";
                inInitrd = true;
                how = "symlink";
                configureParent = true;
              }
              {
                file = "/etc/shadow";
                inInitrd = true;
                how = "symlink";
                configureParent = true;
              }
              {
                file = "/etc/gshadow";
                inInitrd = true;
                how = "symlink";
                configureParent = true;
              }
              {
                file = "/etc/subuid";
                inInitrd = true;
                how = "symlink";
                configureParent = true;
              }
              {
                file = "/etc/subgid";
                inInitrd = true;
                how = "symlink";
                configureParent = true;
              }
              {
                file = "/etc/ssh/ssh_host_rsa_key";
                how = "symlink";
                configureParent = true;
              }
              {
                file = "/etc/ssh/ssh_host_rsa_key.pub";
                how = "symlink";
                configureParent = true;
              }
              {
                file = "/etc/ssh/ssh_host_ed25519_key";
                how = "symlink";
                configureParent = true;
              }
              {
                file = "/etc/ssh/ssh_host_ed25519_key.pub";
                how = "symlink";
                configureParent = true;
              }
            ];

            # Persistent user directories and state for tihdizer
            users.tihdizer = {
              home = "/home/tihdizer";
              directories = [
                # Development & AI Tooling
                "projects"
                "dotfiles"
                ".jcode"

                # Core XDG and Application State
                ".config"
                ".local/state"
                ".local/bin"
                ".local/share/keyrings"
                ".local/share/direnv"
                ".local/share/zsh"
                ".local/share/atuin"
                ".local/share/nix"
                ".local/share/icons"
                ".local/share/fonts"
                ".local/share/TelegramDesktop"
                ".local/share/transmission"

                # Secrets, SSH & GPG Keys
                ".ssh"
                ".gnupg"
                ".pki"

                # Web Browsers & Mail
                ".mozilla"
                ".zen"
                ".floorp"
                ".thunderbird"

                # Media, Documents & Notes
                "downloads"
                "documents"
                "pictures"
                "videos"
                "music"
              ];

              files = [
                ".bash_history"
                ".zsh_history"
              ];
            };
          };
        };
      };
    };
}
