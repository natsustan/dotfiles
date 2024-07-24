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
      name = "macOS";
      paths = with pkgs; [
        fish # fish shell
        mas # mac app store cli
        neovim # vim
        neofetch
        peco # Simplistic interactive filtering tool
        starship # the prompt for shell
        nodejs_20
        nodePackages.pnpm
	# php
        # pandoc # alfred-gpt-dependencies
        # mpv # alfred-gpt-dependencies
        # duti # alfred-gpt-dependencies
        # sox # alfred-gpt-dependencies
        # jq # alfred-gpt-dependencies
        # yarn
        # go
        fava # web interface for beancount
      ];
    };
  };
}
