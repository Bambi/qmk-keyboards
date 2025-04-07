{
  description = "Flake for building qmk firmware";
  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    # https://flake.parts/module-arguments.html
    flake-parts.lib.mkFlake { inherit inputs; } (top@{ config, withSystem, moduleWithSystem, ... }: {
      systems = [
        # systems for which you want to build the `perSystem` attributes
        "x86_64-linux"
      ];
      perSystem = { config, pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          name = "qmk";
          packages = with pkgs; [
            just
            qmk
            stow
          ];
        };
      };
    });
}
