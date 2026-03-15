{ pkgs, userName }:
{

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pulseaudio
  ];

  users.users."${userName}".packages = with pkgs; [
    ## sound related packages

    # TODO:
    # helvm is removed so, I want to find and install an alternative
    pavucontrol
  ];
}
