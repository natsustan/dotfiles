{
  description = "my global env";

  inputs = {
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = { self, nixpkgs, darwin, ... }: {

    packages."aarch64-darwin".default = let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in pkgs.buildEnv {
      name = "global-env";
      paths = with pkgs; [
        mas
        tmux
        neovim
      ];
    };
  };
}