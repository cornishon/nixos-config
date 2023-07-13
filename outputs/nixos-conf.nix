{ inputs, system, ... }:
let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  lib = inputs.nixpkgs.lib;

  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  asus-tuf = nixosSystem {
    inherit lib pkgs system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/configuration.nix
      ../system/machine/asus-tuf
      inputs.hyprland.nixosModules.default
      { programs.hyprland.enable = true; }
    ];
  };
}
