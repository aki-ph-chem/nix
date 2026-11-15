{
  pkgs,
  pkgsGtk2,
  pgopher,
  userName,
}:
let
  # PGOPHER's prebuilt binary (pgopher-x86_64-linux-gtk2.tgz) requires GTK2.
  # Since gtk2 is being removed from nixpkgs (NixOS/nixpkgs#410814), the
  # nixpkgs revision that still ships gtk2 is pinned and its libraries are
  # given to PGOPHER only, via LD_LIBRARY_PATH.
  # The nix-ld stub prepends an existing LD_LIBRARY_PATH to
  # NIX_LD_LIBRARY_PATH, so the libraries prepended here take precedence.
  # See docs/gtk2-pgopher.md for details.
  pgopherGtk2 = pkgs.symlinkJoin {
    name = "pgopher-gtk2";
    paths = [ pgopher.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      gtk2Libs="${
        pkgsGtk2.lib.makeLibraryPath (
          with pkgsGtk2;
          [
            gtk2
            glib
            pango
            at-spi2-core
            cairo
            gdk-pixbuf
            libX11
            libXext
            libXrender
            libXrandr
            libXcursor
            libXcomposite
            libXi
            libXinerama
            cups
          ]
        )
      }"
      for b in $out/bin/pgopher $out/bin/pgo $out/bin/tabslave; do
        wrapProgram "$b" --prefix LD_LIBRARY_PATH : "$gtk2Libs"
      done
    '';
  };
in
{
  users.users."${userName}".packages = with pkgs; [
    # filer
    thunar
    # image viwer
    ristretto
    tumbler # This is required for thumbnail display in 'thunar' and 'ristretto'.

    # movie & music
    vlc

    # pdf viwer
    qpdfview
    zathura
    # for drawing
    inkscape

    # neovim GUI
    neovide
    # tarminal emulator
    wezterm

    # web browser
    chromium
    firefox
    brave
    # e-mail & feed
    thunderbird

    # pgopher
    pgopherGtk2
  ];
}
