{
  description = "My Nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
#    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    nixos-hardware = {
    	url = "github:NixOS/nixos-hardware/master";
    };

  };


  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs: {
	  nixosConfigurations = {
		  default = nixpkgs.lib.nixosSystem {
			  specialArgs = {inherit inputs;};
			  modules = [
				  ./device/default/configuration.nix
				  nixos-hardware.nixosModules.framework-13-7040-amd
			  ];
		  };

#		  workstation = nixpkgs.lib.nixosSystem {
#			  specialArgs = {inherit inputs;};
#			  modules = [
#			  	./device/workstation/configuration.nix
#			  ];
#		  };
#
	  };
  };
}
