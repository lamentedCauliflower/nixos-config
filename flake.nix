{
	description = "Isaac's NixOS Configuration";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
	};

	outputs = {self, nixpkgs, ...}@inputs: {
		nixosConfigurations = {

		luna-nixos = let
			username = "isaac";
			specialArgs = {inherit username;};
		in
			nixpkgs.lib.nixosSystem {
				inherit specialArgs;
				system = "x86_64-linux";
				modules = [
					./hosts/luna-nixos
					./modules/system.nix
				];
			};
		};
	};
}
