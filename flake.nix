{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs = inputs: {
    packages = builtins.mapAttrs (system: pkgs: rec {
      fxbox = pkgs.writeShellScriptBin "fxbox" ''
        ${pkgs.gum}/bin/gum style \
          --border double \
          --margin "1 2" \
          --padding "1 4" \
          "$@"
      '';
      fxspin = pkgs.writeShellScriptBin "fxspin" ''
        title="$1"
        shift
        if [[ "$FLOX_ENVS_TESTING" == "1" ]]; then
            ${pkgs.runtimeShell} -c "$@"
        else
            printf "%s\n"
            ${pkgs.gum}/bin/gum spin \
              --show-error \
              --spinner line \
              --spinner.foreground="#cccccc" \
              --title ">>> $title ..." \
              --title.foreground="#cccccc" \
              -- ${pkgs.runtimeShell} -c "$@"
            echo -en "\033[2A\033[K"
        fi
      '';
      default = pkgs.buildEnv {
        name = "env-utils";
        paths = [
          fxbox
          fxspin
        ];
      };
    }) inputs.nixpkgs.legacyPackages;
  };
}
