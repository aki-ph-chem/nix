{ config, pkgs, ... }:
{

  home.packages = [
    pkgs.nixgl.nixGLMesa
  ];
}
