{
  description = "Declarative per-user state management for NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    nixpkgs,
    ...
  }: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed  (system: function nixpkgs.legacyPackages.${system});
  in {
    nixosModules = rec {
      nixum = ./modules;
      default = nixum;
    };

    formatter = forAllSystems (pkgs: pkgs.alejandra);
  };
}