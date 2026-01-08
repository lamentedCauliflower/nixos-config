{
  description = "Isaac's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =

    inputs@{ nixpkgs, home-manager, ... }:
    {
      nixosConfigurations = {

        luna-nixos =
          let
            username = "isaac";
            specialArgs = { inherit username; };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [
              ./hosts/luna-nixos
              ./modules/system.nix
            ];
          };

        yuro-nixos =
          let
            username = "isaac";
            specialArgs = { inherit username; };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [
              ./hosts/yuro-nixos
              ./modules/system.nix
              ./modules/hyprland.nix
              ./modules/development.nix
              ./modules/graphical/development.nix
              ./modules/graphical/browsers.nix
              ./modules/graphical/utilities.nix
              ./modules/graphical/gaming.nix

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = inputs // specialArgs;
                home-manager.users.${username} = import ./users/${username}/home.nix;
              }
            ];
          };
      };
    };
}
