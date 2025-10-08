{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
	  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
		  system = "x86_64-linux";
		  specialArgs = { inherit inputs; };
		  modules = [ 
			  ./hosts/nixos/configuration.nix 
			  ./hyprland.nix 
			  inputs.home-manager.nixosModules.default
		  ];
	  };
  };
}
