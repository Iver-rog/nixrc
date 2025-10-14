{ pkgs, user, ... }: {
  environment.systemPackages = with pkgs; [ virt-manager spice-gtk swtpm ];
  security.polkit.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf = {
          enable = true;
          packages = with pkgs; [ OVMFFull.fd ];
        };
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  home-manager.users."${user}" = {

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
      };
    };
  };
}
