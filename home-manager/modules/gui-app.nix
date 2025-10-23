{ config, pkgs, ... }:
let
  qpdfvieWrapper = pkgs.writeShellScriptBin "qpdfview" ''
    exec ${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa  ${pkgs.qpdfview}/bin/qpdfview "$@" 
  '';
in
{

  home.packages = [
    pkgs.nixgl.nixGLMesa
    qpdfvieWrapper
  ];
}
