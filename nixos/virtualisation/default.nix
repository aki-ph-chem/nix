{
  pkgs,
  containerd-shim-wasmtime-v1,
  isAutoStart ? false,
  ...
}:
let
  serviceTarget = if isAutoStart then [ "multi-user.target" ] else pkgs.lib.mkForce [ ];
in
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

  systemd.services = {
    # Docker
    docker.wantedBy = serviceTarget;

    # containerd
    containerd = {
      wantedBy = serviceTarget;
      path = [
        containerd-shim-wasmtime-v1.packages.x86_64-linux.default
      ];
    };

    # for libvirt + QEMU
    libvirtd.wantedBy = serviceTarget;
    virtqemud.wantedBy = serviceTarget;
  };
}
