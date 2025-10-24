{ config, pkgs, ... }:
let
  qpdfvieWrapper = pkgs.writeShellScriptBin "qpdfview" ''
    exec ${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa  ${pkgs.qpdfview}/bin/qpdfview "$@" 
  '';
in
{
  xdg.desktopEntries."qpdfview.desktop" = {
    type = "Application";
    name = "qpdfview";
    exec = "${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa  ${pkgs.qpdfview}/bin/qpdfview";
  };

  home.packages = [
    pkgs.nixgl.nixGLMesa
    qpdfvieWrapper
  ];
}
