{ config, pkgs, ... }:
let
  qpdfvieWrapper = pkgs.writeShellScriptBin "qpdfview" ''
    exec ${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa  ${pkgs.qpdfview}/bin/qpdfview "$@" 
  '';
  zathuraWrapper = pkgs.writeShellScriptBin "zathura" ''
    exec ${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa  ${pkgs.zathura}/bin/zathura "$@" 
  '';
in
{
  xdg.desktopEntries."qpdfview.desktop" = {
    type = "Application";
    name = "qpdfview";
    exec = "${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa  ${pkgs.qpdfview}/bin/qpdfview";
  };
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

  home.packages = [
    pkgs.nixgl.nixGLMesa
    qpdfvieWrapper
    zathuraWrapper
  ];
}
