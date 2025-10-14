{ config, pkgs, inputs, ... }:

{
  # WSL-specific configuration
  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = "iver";
  };

  # User configuration
  users.users.iver = {
    isNormalUser = true;
    description = "Iver Rogstadkjernet";
    extraGroups = [ "wheel" ];
    # Development packages handled by home-manager
    packages = with pkgs; [ ];
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "iver" = {
        imports = [ ../../home.nix ];
        home.username = "iver";
        home.homeDirectory = "/home/iver";
        home.stateVersion = "24.05";
      };
    };
  };

  # System packages (minimal for WSL - home-manager handles dev tools)
  environment.systemPackages = with pkgs; [
    # Only essential system tools
  ];

  # Enable SSH
  services.openssh.enable = true;

  # Nix configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.extraOptions = ''
    trusted-users = root iver
  '';

  # Programs
  programs.neovim.defaultEditor = true;

  system.stateVersion = "24.05";
}
