{ inputs, ... }:
{
  flake.modules.nixos.test-vm =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        # Импортируем текущий disko модуль
        inputs.self.modules.nixos.host-main-disko
      ];

      networking.hostName = "test-vm";

      # 1. Переопределяем реальные диски на виртуальные образы QEMU
      disko.devices.disk = {
        nvme = {
          device = lib.mkForce "/dev/vda";
          imageSize = "10G";
        };
        sata1 = {
          device = lib.mkForce "/dev/vdb";
          imageSize = "4G";
        };
        sata2 = {
          device = lib.mkForce "/dev/vdc";
          imageSize = "4G";
        };
        hdd1 = {
          device = lib.mkForce "/dev/vdd";
          imageSize = "4G";
        };
        hdd2 = {
          device = lib.mkForce "/dev/vde";
          imageSize = "4G";
        };
      };

      # 2. Настройки виртуализации QEMU для 5 дисков с прямым запуском ядра
      virtualisation.vmVariant = {
        virtualisation = {
          memorySize = 4096;
          cores = 4;
          graphics = false;
          diskSize = 10240; # 10 GB для /dev/vda (nvme)
          emptyDiskImages = [
            4096 # /dev/vdb (sata1)
            4096 # /dev/vdc (sata2)
            4096 # /dev/vdd (hdd1)
            4096 # /dev/vde (hdd2)
          ];
          useDefaultFilesystems = false;
          fileSystems = {
            "/" = {
              device = "tmpfs";
              fsType = "tmpfs";
              options = [
                "size=4G"
                "mode=755"
              ];
            };
          };
          useBootLoader = false;
        };
      };

      # 3. Автоматическая разметка и монтирование дисков через Disko при старте VM
      systemd.services.disko-init = {
        description = "Initialize Disko disks on test-vm boot";
        wantedBy = [ "multi-user.target" ];
        after = [ "local-fs.target" ];
        path = with pkgs; [
          btrfs-progs
          util-linux
          parted
          e2fsprogs
          dosfstools
        ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${config.system.build.diskoScript}";
        };
      };

      # 4. Минимальная конфигурация для быстрой загрузки
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = false;

      # Автологин под root в консоль
      services.getty.autologinUser = lib.mkForce "root";
      users.users.root.password = "";

      # Сеть для VM
      networking.useDHCP = false;
      system.stateVersion = "25.11";

      # Вспомогательные утилиты для инспекции
      environment.systemPackages = with pkgs; [
        btrfs-progs
        util-linux
        config.system.build.diskoScript
        (writeShellScriptBin "check-storage" ''
          echo "=================== BLOCK DEVICES ==================="
          lsblk -f
          echo ""
          echo "=================== MOUNT POINTS ===================="
          findmnt -t tmpfs,btrfs,vfat
          echo ""
          echo "=================== BTRFS FILESYSTEMS ==============="
          btrfs filesystem show
          echo ""
          echo "=================== SWAP DEVICES ===================="
          swapon -s
          echo "====================================================="
        '')
      ];
    };

  flake.nixosConfigurations.test-vm = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.self.modules.nixos.test-vm
    ];
  };

  flake.packages.x86_64-linux.test-vm =
    inputs.self.nixosConfigurations.test-vm.config.system.build.vm;

  flake.apps.x86_64-linux.test-vm = {
    type = "app";
    program = "${inputs.self.packages.x86_64-linux.test-vm}/bin/run-${inputs.self.nixosConfigurations.test-vm.config.networking.hostName}-vm";
  };
}
