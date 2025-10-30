{ config, pkgs, ... }:
let
  qpdfvieWrapper = pkgs.writeShellScriptBin "qpdfview" ''
    exec ${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa  ${pkgs.qpdfview}/bin/qpdfview "$@" 
  '';
  zathuraWrapper = pkgs.writeShellScriptBin "zathura" ''
    exec ${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa  ${pkgs.zathura}/bin/zathura "$@" 
  '';
  ristrettoWrapper = pkgs.writeShellScriptBin "ristretto" ''
    exec ${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa  ${pkgs.xfce.ristretto}/bin/ristretto "$@" 
  '';
in
{
  # qpdfview
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

  # zathura
  xdg.desktopEntries."zathura.desktop" = {
    type = "Application";
    name = "Zathura";
    comment = "A minimalistic document viewer";
    terminal = false;
    noDisplay = false;
    categories = [
      "Office"
      "Viewer"
    ];
    mimeType = [
      "application/pdf"
      "application/oxps"
      "application/epub+zip"
      "application/x-fictionbook"
    ];
    exec = "${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa  ${pkgs.zathura}/bin/zathura";
    icon = "${pkgs.zathura}/share/icons/hicolor/scalable/apps/org.pwmt.zathura.svg";
  };

  # ristretto
  xdg.desktopEntries."ristretto.desktop" = {
    type = "Application";
    name = "Ristretto Image Viewer";
    comment = "Look at your images easily";
    genericName = "Image Viewer";
    terminal = false;
    noDisplay = false;
    exec = "${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa  ${pkgs.xfce.ristretto}/bin/ristretto";
    icon = "${pkgs.xfce.ristretto}/share/icons/hicolor/scalable/apps/org.xfce.ristretto.svg";
  };

  home.packages = [
    pkgs.nixgl.nixGLMesa
    qpdfvieWrapper
    zathuraWrapper
    ristrettoWrapper
  ];
}
