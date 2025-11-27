{ pkgs, userName }:
{

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users."${userName}".packages = with pkgs; [
    ## sound related packages
    helvum
    pavucontrol
  ];
}
