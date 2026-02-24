{
  description = "NixOS configuration for taipei";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nix-config = {
      url = "github:GrimOutlook/nix-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nix-config, ... }:
    nix-config.inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        nix-config.modules.flake.hosts
        nix-config.modules.flake.host-info
        (nix-config + "/modules/flake/systems.nix")
      ];
      host-info.flake = "github:GrimOutlook/nix-host-taipei";
      host = {
        name = "taipei";
        nixos = {
          modules = with nix-config.modules.nixos; [
            dev
            wsl
          ];
          system = {
            autoUpgrade.enable = true;
            stateVersion = "25.05";
          };
        };
        home = {
          modules = with nix-config.modules.homeManager; [
            dev
            networking
          ];
          home.stateVersion = "25.11";
        };
      };
    };
}
