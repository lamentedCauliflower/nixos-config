{
  description = "Isaac's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    opencode = {
      url = "github:anomalyco/opencode/v1.1.53";
    };
  };

  outputs =

    inputs@{
      nixpkgs,
      home-manager,
      stylix,
      nur,
      opencode,
      ...
    }:
    let
      # Allow unfree packages globally
      pkgsConfig = {
        allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {

        luna-nixos =
          let
            username = "isaac";
            specialArgs = { inherit username; };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = [
              { nixpkgs.config = pkgsConfig; }
              ./hosts/luna-nixos
              ./modules/system.nix
            ];
          };

        yuro-nixos =
          let
            username = "isaac";
            specialArgs = {
              inherit username;
            }
            // inputs;
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = [
              { nixpkgs.config = pkgsConfig; }
              ./hosts/yuro-nixos
              ./modules/system.nix
              ./modules/hyprland.nix
              ./modules/development.nix
              ./modules/graphical/development.nix
              ./modules/graphical/browsers.nix
              ./modules/graphical/utilities.nix
              ./modules/graphical/gaming.nix
              ./modules/graphical/design.nix
              stylix.nixosModules.stylix
              nur.modules.nixos.default

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  device = "laptop";
                }
                // inputs
                // specialArgs;
                home-manager.users.${username} = import ./users/${username}/home.nix;
              }
            ];
          };

        cleo-nixos =
          let
            username = "isaac";
            specialArgs = {
              inherit username;
            }
            // inputs;
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = [
              { nixpkgs.config = pkgsConfig; }
              ./hosts/cleo-nixos
              ./modules/system.nix
              ./modules/hyprland.nix
              ./modules/development.nix
              ./modules/graphical/development.nix
              ./modules/graphical/browsers.nix
              ./modules/graphical/utilities.nix
              ./modules/graphical/gaming.nix
              ./modules/graphical/design.nix
              stylix.nixosModules.stylix
              nur.modules.nixos.default

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  device = "desktop";
                }
                // inputs
                // specialArgs;
                home-manager.users.${username} = import ./users/${username}/home.nix;
              }
            ];
          };
      };
    };
}
