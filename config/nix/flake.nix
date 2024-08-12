{
  description = "Nix for macOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    devenv.url = "github:cachix/devenv/latest";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, devenv, disko }: 
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = pkgs.buildEnv {
        name = "macOS";
        paths = with pkgs; [
          starship
          zsh-autosuggestions
          zsh-syntax-highlighting
          zsh-z
	  eza
          autocorrect
          mas
          neovim
          neofetch
          pyenv
          peco
          nodejs_20
          nodePackages.pnpm
        ];
      };
    };
}
