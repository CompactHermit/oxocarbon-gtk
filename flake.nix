{
  description = "Oxocarbon GTK-ified";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    parts.url = "github:Hercules-CI/flake-parts";
  };

  outputs = inputs@{ parts, ... }:
    parts.lib.mkFlake { inherit inputs; } {
      imports = [];
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "oxocarbon-gtk";
          version = "0.0.1";

          src = ./oxocarbon-gtk;

          sourceRoot = ".";

          propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];


  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    cp -a ./oxocarbon-gtk* $out/share/themes
    runHook postInstall
    '';
        };
      };
    };
}
