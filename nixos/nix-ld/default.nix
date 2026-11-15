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

      # GTK/GLib (gtk2 for PGOPHER is provided separately by the gui-app
      # module; see docs/gtk2-pgopher.md)
      glib
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
