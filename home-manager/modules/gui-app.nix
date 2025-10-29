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
    icon = "${pkgs.qpdfview}/share/icons/hicolor/scalable/apps/qpdfview.svg";
    terminal = false;
    genericName = "tabbed document viewer";
    comment = "A tabbed document viewer using Qt and the Poppler library.";
    categories = [
      "Viewer"
      "Office"
    ];
  };

  home.packages = [
    pkgs.nixgl.nixGLMesa
    qpdfvieWrapper
  ];
}
