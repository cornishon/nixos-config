{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "asus-tuf";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.asusd = {
    enable = false;
    enableUserService = false;
  };

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-a4f7961c-e4a3-479b-9295-ea1626bc0c43".device = "/dev/disk/by-uuid/a4f7961c-e4a3-479b-9295-ea1626bc0c43";
  boot.initrd.luks.devices."luks-a4f7961c-e4a3-479b-9295-ea1626bc0c43".keyFile = "/crypto_keyfile.bin";
}
