# modules/apps.nix
{ pkgs, ... }:

{
  # 定义要安装的应用程序
  environment.systemPackages = with pkgs; [
    starship
    # zsh-autosuggestions
    # zsh-syntax-highlighting
    # zsh-z
    fish
    fishPlugins.z
    autocorrect
    mas
    neovim
    neofetch
    peco
    nodejs_20
    nodePackages.pnpm
  ];

  # 你也可以在这里定义一些与应用程序相关的配置
  programs.zsh.enable = true;
  programs.fish.enable = true;
}
