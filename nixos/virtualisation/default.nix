{ pkgs }:
{

  virtualisation = {
    # Docker
    docker = {
      enable = true;
    };

    # QEMU/KVM by libvirt
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };
  programs.virt-manager.enable = true;

}
