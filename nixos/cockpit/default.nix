{ pkgs, ... }: {
  services.cockpit = {
    enable = true;
    port = 9090;
  };
  security.pam.services.cockpit.enable = true;
}
