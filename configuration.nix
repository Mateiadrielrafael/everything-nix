{ pkgs, lib, ... }:
let
  theme = pkgs.myThemes.current;
in
{
  imports = [ ./modules ];

  boot.tmpOnTmpfs = false;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.xserver.videoDrivers = [
    # "displaylink"
    "modesetting"
  ];

  hardware.pulseaudio.enable = lib.mkForce false;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  boot.loader = {
    # systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
      efiSysMountPoint = "/boot";
    };
    grub = {
      # despite what the configuration.nix manpage seems to indicate,
      # as of release 17.09, setting device to "nodev" will still call
      # `grub-install` if efiSupport is true
      # (the devices list is not used by the EFI grub install,
      # but must be set to some value in order to pass an assert in grub.nix)
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      # set $FS_UUID to the UUID of the EFI partition
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root $FS_UUID
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
      # theme = theme.grub.path;

      version = 2;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable sound.
  sound.enable = true;

  system.stateVersion = "19.03";
  home-manager.users.adrielus.home.stateVersion = "19.03";

  # TODO: put nixpkgs stuff inside their own file
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
}

