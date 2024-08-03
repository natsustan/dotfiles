# modules/system.nix
{ pkgs, ... }:

{
  system = {
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true;
      # 其他 macOS 默认设置
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";  # 启用深色模式
        # AppleKeyboardUIMode = 3;  # 全键盘控制
        # InitialKeyRepeat = 15;
        # KeyRepeat = 2;
        # NSAutomaticCapitalizationEnabled = false;
        # NSAutomaticDashSubstitutionEnabled = false;
        # NSAutomaticPeriodSubstitutionEnabled = false;
        # NSAutomaticQuoteSubstitutionEnabled = false;
        # NSAutomaticSpellingCorrectionEnabled = false;
      };
    };
  };

  # 启用 TouchID 认证
  security.pam.enableSudoTouchIdAuth = true;

  # 其他系统级别的设置
}
