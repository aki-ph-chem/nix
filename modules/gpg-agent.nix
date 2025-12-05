{
  config,
  pkgs,
  ...
}:
{

  # use need to restart gpg-agent as below:
  # gpgconf --kill gpg-agent
  home.packages = [
    pkgs.pinentry-rofi
  ];
  home.file = {
    ".gnupg/gpg-agent.conf" = {
      text = ''
        pinentry-program ${config.home.homeDirectory}/.nix-profile/bin/pinentry-rofi
      '';
    };
  };

}
