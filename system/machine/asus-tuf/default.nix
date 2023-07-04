{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "asus-tuf";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.asusd = {
    enable = true;
    enableUserService = true;
    asusdConfig = ''
      (
        bat_charge_limit: 80,
      )
    '';
  };
  services.supergfxd.enable = false;
  environment.systemPackages = with pkgs; [ zenstates msr kmod microcodeAmd ];

  systemd.services."disable-c6" = {
    unitConfig = {
      Description = "Ryzen Disable C6 (fixes suspend to ram)";
      DefaultDependencies = "no";
      After = "sysinit.target local-fs.target suspend.target hibernate.target";
      Before = "basic.target";
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.kmod}/bin/modprobe msr";
      ExecStart = "${pkgs.zenstates}/bin/zenstates --c6-disable";
    };
    wantedBy = [ "basic.target" "suspend.target" "hibernate.target" ];
  };

  # Setup keyfile
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-a4f7961c-e4a3-479b-9295-ea1626bc0c43".device =
    "/dev/disk/by-uuid/a4f7961c-e4a3-479b-9295-ea1626bc0c43";
  boot.initrd.luks.devices."luks-a4f7961c-e4a3-479b-9295-ea1626bc0c43".keyFile =
    "/crypto_keyfile.bin";
}
