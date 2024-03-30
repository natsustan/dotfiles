{
  description = "Nix for macOS configuration";

  inputs = {
	  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv/latest";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs,devenv,disko }: {

    packages."aarch64-darwin".default = let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in pkgs.buildEnv {
      name = "global-env";
      paths = with pkgs; [
        mas
        tmux
        neovim
        neofetch
      ];
    };
  };
}