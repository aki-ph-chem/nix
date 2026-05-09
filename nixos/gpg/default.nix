{ pkgs, userName }:

let
  pinentry-auto = pkgs.writeShellScriptBin "pinentry-auto" ''
    #!${pkgs.runtimeShell}

    if [ -n "$WAYLAND_DISPLAY" ] || [ -n "$DISPLAY" ]; then
      exec ${pkgs.pinentry-rofi}/bin/pinentry-rofi
    fi

    # fallback
    exec ${pkgs.pinentry-curses}/bin/pinentry-curses
  '';
in
{

  programs.gnupg = {
    agent = {
      enable = true;
      enableExtraSocket = true;
      pinentryPackage = pinentry-auto;
    };
  };

  # for Yubikey
  services.pcscd.enable = true;
  programs.yubikey-manager.enable = true;
  services.yubikey-agent.enable = true;
}
