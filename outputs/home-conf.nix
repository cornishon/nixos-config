{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  imports = [ inputs.nixvim.homeManagerModules.nixvim ../home/home.nix ];
in {
  adamz = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    extraSpecialArgs = { inherit inputs; };

    modules = [{ inherit imports; }];
  };
}
