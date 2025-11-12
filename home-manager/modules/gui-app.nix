{ config, pkgs, ... }:
let
  nixGl = "${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa";
  qpdfvieWrapper = pkgs.writeShellScriptBin "qpdfview" ''
    exec ${nixGl} ${pkgs.qpdfview}/bin/qpdfview "$@" 
  '';
  zathuraWrapper = pkgs.writeShellScriptBin "zathura" ''
    exec ${nixGl} ${pkgs.zathura}/bin/zathura "$@" 
  '';
  ristrettoWrapper = pkgs.writeShellScriptBin "ristretto" ''
    exec ${nixGl} ${pkgs.xfce.ristretto}/bin/ristretto "$@" 
  '';
  # neovide
  neovideWrapper = pkgs.writeShellScriptBin "neovide" ''
    exec ${nixGl} ${pkgs.neovide}/bin/neovide "$@" 
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
    exec = "${nixGl} ${pkgs.qpdfview}/bin/qpdfview";
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
    exec = "${nixGl} ${pkgs.zathura}/bin/zathura";
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
    exec = "${nixGl} ${pkgs.xfce.ristretto}/bin/ristretto";
    icon = "${pkgs.xfce.ristretto}/share/icons/hicolor/scalable/apps/org.xfce.ristretto.svg";
  };

  home.packages = [
    pkgs.nixgl.nixGLMesa
    qpdfvieWrapper
    zathuraWrapper
    ristrettoWrapper
    neovideWrapper
  ];
}
