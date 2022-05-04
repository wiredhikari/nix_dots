{inputs = {
nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";	
nix.url = "github:nixos/nix";
nixpkgs-f2k.inputs.nixpkgs.follows = "nixpkgs";
};




 outputs = inputs@{ self, nixpkgs,nixpkgs-f2k , ... }:
  {
   nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
     modules = [
        { nixpkgs.overlays = [ nixpkgs-f2k.overlay ]; }
        ./configuration.nix
      ];

    specialArgs = { inherit inputs; };
    };
  };
}
