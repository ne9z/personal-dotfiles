{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      mkHost = hostName: system:
        (({ zfs-root, pkgs, system, ... }:
          nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              # Module 0: zfs-root and my-config
              ./modules

              # Module 1: host-specific config, if exist
              (if (builtins.pathExists
                ./hosts/${hostName}/configuration.nix) then
                (import ./hosts/${hostName}/configuration.nix { inherit pkgs; })
              else
                { })

              # Module 2: entry point
              (({ zfs-root, pkgs, lib, ... }: {
                inherit zfs-root;
                system.configurationRevision = if (self ? rev) then
                  self.rev
                else
                  throw "refuse to build: git tree is dirty";
                system.stateVersion = "23.05";
                imports = [
                  "${nixpkgs}/nixos/modules/installer/scan/not-detected.nix"
                  "${nixpkgs}/nixos/modules/profiles/hardened.nix"
                ];
              }) {
                inherit zfs-root pkgs;
                lib = nixpkgs.lib;
              })

              # Module 3: home-manager
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
              }
            ];
          }) (import ./hosts/${hostName} {
            system = system;
            pkgs = nixpkgs.legacyPackages.${system};
          }));
    in {
      nixosConfigurations = {
        exampleHost = mkHost "exampleHost" "x86_64-linux";
        qinghe = mkHost "qinghe" "x86_64-linux";
        tieling = mkHost "tieling" "x86_64-linux";
        yinzhou = mkHost "yinzhou" "x86_64-linux";
        shuiku = mkHost "shuiku" "x86_64-linux";
      };
    };
}
