{ config, pkgs, ... }:

let
  nixGl = "${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa";
  # neovide
  neovideWrapper = pkgs.writeShellScriptBin "neovide" ''
    exec ${nixGl} ${pkgs.neovide}/bin/neovide "$@" 
  '';
in

{
  # neovide
  xdg.desktopEntries."neovide" = {
    type = "Application";
    name = "Neovide";
    comment = "No Nonsense Neovim Client in Rust";
    categories = [
      "Utility"
      "TextEditor"
    ];
    mimeType = [
      "text/english"
      "text/plain"
      "text/x-makefile"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-java"
      "text/x-moc"
      "text/x-pascal"
      "text/x-tcl"
      "text/x-tex"
      "application/x-shellscript"
      "text/x-c"
      "text/x-c++"
    ];
    exec = "${nixGl} ${pkgs.neovide}/bin/neovide";
    icon = "${pkgs.neovide}/share/icons/hicolor/scalable/apps/neovide.svg";
  };

  home.packages = [
    neovideWrapper
  ];
}
