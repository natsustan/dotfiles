{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages."aarch64-darwin".default = let
      system = "aarch64-darwin";
      name = "macOS";
      paths = with pkgs; [
        neofetch
      ];
    };
}