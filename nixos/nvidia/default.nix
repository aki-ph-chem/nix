{ pkgs }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    graphics.enable = true;
    nvidia.open = true; # for newer than Turing
    nvidia.modesetting.enable = true; # for Wayland
  };
}
