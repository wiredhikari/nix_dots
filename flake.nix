{
inputs = {
	nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";	
	nix.url = "github:nixos/nix";
	nixpkgs-f2k.inputs.nixos-unstable.follows = "nixpkgs";
	nixpkgs.url = "nixpkgs/nixos-22.05";
	home-manager.url = "github:nix-community/home-manager/release-21.11";
};

 outputs = inputs@{ self, nixpkgs,nixpkgs-f2k, home-manager, ... }:
  {
   nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
        { nixpkgs.overlays = [ nixpkgs-f2k.overlays.default ]; }
        ./configuration.nix
      ];
  };
};
}
