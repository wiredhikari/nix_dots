{inputs.nix.url = "github:nixos/nix";
 outputs = inputs@{ self, nixpkgs, ... }:
  {
    nixosConfigurations.wired = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ (import ./configuration.nix) ];
      specialArgs = { inherit inputs; };
    };
  };
}
