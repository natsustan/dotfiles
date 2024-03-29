{
  description = "my global env";

  nixConfig = {
    substituters = [
      # Query the mirror of USTC first, and then the official cache.
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
	  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	  devenv.url = "github:cachix/devenv/latest";
	  disko.url = "github:nix-community/disko";
	  disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs,devenv,disko }: {
    # profile for my arm -darwin machine
    
    packages."aarch64-darwin".default = let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in pkgs.buildEnv {
      name = "global-env";
      paths = with pkgs; [
        # nodejs_20
        # nodePackages.pnpm
        # nodePackages.grunt-cli
        # wget
        mas
        tmux
        neovim
      ];
    };
  };
}
