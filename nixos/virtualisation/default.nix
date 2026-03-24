{ pkgs, containerd-shim-wasmtime-v1 }:
{

  virtualisation = {
    # Docker
    docker = {
      enable = true;
    };

    # cotainerd
    containerd = {
      enable = true;
    };

    containers = {
      enable = true;
      # policy for containers
      policy = {
        default = [
          { type = "insecureAcceptAnything"; }
        ];
      };
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

  environment.systemPackages = with pkgs; [
    nerdctl
    buildah
  ];

  systemd.services.containerd = {
    path = [
      containerd-shim-wasmtime-v1.packages.x86_64-linux.default
    ];
  };
}
