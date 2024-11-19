{
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs
          {
            config.allowUnfree = true;
            inherit system;
          };
          env-utils = pkgs.runCommandNoCC "env-utils"
          {
            buildInputs = [
              pkgs.gum
            ];
          }
          ''
            mkdir -p $out/share/
            substitute ${./env-utils.sh} $out/share/env-utils.sh \
              --subst-var-by gum ${pkgs.gum}/bin/gum \
          '';
    in
        {
          default = env-utils;
        }
      );
    };
}
