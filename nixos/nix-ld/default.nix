{ pkgs }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # X11
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libXrandr
      xorg.libXcursor
      xorg.libXcomposite
      xorg.libXtst
      xorg.libXfixes
      xorg.libxcb
      xorg.libXdamage
      xorg.libxshmfence
      xorg.libXxf86vm

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
