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
    comment = "A tabbed document viewer using Qt and the Poppler library.";
    genericName = "tabbed document viewer";
    terminal = false;
    categories = [
      "Viewer"
      "Office"
    ];
    mimeType = [
      "application/pdf"
      "application/x-pdf"
      "text/pdf"
      "text/x-pdf"
      "image/pdf"
      "image/x-pdf"
      "application/postscript"
      "image/vnd.djvu"
      "image/x-djvu"
    ];
    exec = "${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa  ${pkgs.qpdfview}/bin/qpdfview";
    icon = "${pkgs.qpdfview}/share/icons/hicolor/scalable/apps/qpdfview.svg";
  };

  home.packages = [
    pkgs.nixgl.nixGLMesa
    qpdfvieWrapper
  ];
}
