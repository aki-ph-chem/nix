{ pkgs }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # X11
      libX11
      libXext
      libXrender
      libXrandr
      libXcursor
      libXcomposite
      libXtst
      libXfixes
      libxcb
      libXdamage
      libxshmfence
      libXxf86vm

      # GTK2
      glib
      gtk2
      gdk-pixbuf

      # others
      zlib
      pango
      atk
      cairo
      stdenv.cc.cc
    ];
  };
}
