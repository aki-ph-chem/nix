{ pkgs, userName }:
{

  programs.gnupg = {
    agent = {
      enable = true;
      enableExtraSocket = true;
      # use pinentry-rofi
      pinentryPackage = pkgs.pinentry-rofi;
    };
  };

  # for Yubikey
  services.pcscd.enable = true;
  programs.yubikey-manager.enable = true;
  services.yubikey-agent.enable = true;
}
