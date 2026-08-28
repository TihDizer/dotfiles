{ ... }:
{
  flake.modules.nixos.system-peripherals =
    { pkgs, ... }:
    {
      services.hardware.openrgb.enable = true;
      hardware.keyboard.qmk.enable = true;

      services.udev.packages = with pkgs; [
        qmk-udev-rules
      ];

      environment.systemPackages = with pkgs; [
        dfu-util
        dfu-programmer
        usbutils
      ];

      boot.kernelModules = [
        "hid-generic"
        "usbhid"
      ];

      services.udev.extraRules = ''
        # WebHID access for hidraw devices
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", GROUP="users", TAG+="uaccess"

        # WebUSB access for raw USB devices (needed for Nordic DFU / WebUSB firmware flashing)
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0666", GROUP="users", TAG+="uaccess"

        # USB DFU (Device Firmware Upgrade) bootloader mode
        SUBSYSTEM=="usb", ATTR{bInterfaceClass}=="fe", ATTR{bInterfaceSubClass}=="01", MODE="0666", GROUP="users", TAG+="uaccess"

        # Rapoo (mice / receivers / controllers)
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="24ae", MODE="0666", GROUP="users", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"

        # Nordic Semiconductor (MCU / DFU bootloader used inside Rapoo VT3 MAX & wireless dongles)
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="1915", MODE="0666", GROUP="users", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"

        # Keychron (keyboards / mice / receivers / STM32 / RP2040 / Atmel bootloaders)
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="3434", MODE="0666", GROUP="users", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", MODE="0666", GROUP="users", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", MODE="0666", GROUP="users", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", MODE="0666", GROUP="users", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"

        # Logitech (mice / keyboards / receivers / bootloaders)
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="046d", MODE="0666", GROUP="users", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
      '';
    };
}

