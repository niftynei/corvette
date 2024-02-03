{
  description = "lnsocket enabled react app";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            bashInteractive
            jq
            nodejs_21
            nodePackages.npm
            nodePackages.degit
          ];
          # Automatically startup dev env when entering the shell.
          shellHook = "cd corvette && npm install && npm run dev";
        };
      });
}
