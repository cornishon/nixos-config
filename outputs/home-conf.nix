{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  imports = [ ../home/home.nix ];
in {
  adamz = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    extraSpecialArgs = { inherit inputs; };

    modules = [
      { inherit imports; }
      inputs.hyprland.homeManagerModules.default
      { wayland.windowManager.hyprland.enable = true; }
    ];
  };
}
