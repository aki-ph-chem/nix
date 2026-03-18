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
      settings = {
        ## config for containerd-shim-wasmtime-v1
        plugins."io.containerd.grpc.v1.cri".containerd.runtimes.wasm = {
          runtime_type = "io.containerd.wasmtime.v1";
        };
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
    containerd-shim-wasmtime-v1.packages.x86_64-linux.default
  ];

  systemd.services.containerd = {
    path = [
      containerd-shim-wasmtime-v1.packages.x86_64-linux.default
    ];
  };
}
