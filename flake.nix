{
  description = "Home Manager & NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      #inherit (inputs.nixpkgs.lib) mapAttrs;
    in
    {
      homeConfigurations =
        import ./outputs/home-conf.nix { inherit inputs system; };

      nixosConfigurations =
        import ./outputs/nixos-conf.nix { inherit inputs system; };
    };      
}
