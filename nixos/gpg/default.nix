{ pkgs, userName }:
{

  users.users."${userName}" = {
    packages = with pkgs; [
      gnupg
    ];
  };

  # for smart card like Yubikey
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableExtraSocket = true;
  };
}
