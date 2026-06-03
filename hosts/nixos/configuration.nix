{ config, pkgs, inputs, user,... }:

let
  personalPackages = (import ../../packages.nix { inherit pkgs; }).systemPackages;
in
{
  imports = [
    ./hardware-configuration.nix
    # ../../lib/vm.nix
    ../../lib/tor.nix
    ../../lib/vpn.nix
    ../../hyprland.nix
    ../../niri.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "razer";
  networking.networkmanager.enable = true;

  # Localization
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "nb_NO.UTF-8";

  # Desktop Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  console.keyMap = "no";
    services.xserver.xkb = {
    layout = "no";
    variant = "";
  };

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Hardware
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.openrazer.enable = true;

  # Services
  services.printing.enable = true;
  services.flatpak.enable = true;
  services.solaar.enable = true;
  services.openssh.enable = true;

  # XDG Portal
  xdg.portal.enable = true;

  # Virtualization
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # User configuration
  users.users.${user} = {
    isNormalUser = true;
    description = "Iver Rogstadkjernet";
    extraGroups = [ "networkmanager" "wheel" "openrazer" ];
    packages = (import ../../packages.nix { inherit pkgs; }).packages;
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs user; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "${user}" = {
        imports = [ ../../home.nix ];
        home.username = "${user}";
        home.homeDirectory = "/home/${user}";
        home.stateVersion = "24.05";
        
        # Add personal packages to home-manager
        home.packages = (import ../../packages.nix { inherit pkgs; }).packages;
        
      };
    };
  };

  # System packages (only personal/system-specific packages)
  environment.systemPackages = personalPackages;

  # Fonts
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  # Programs
  programs.firefox.enable = true;
  programs.neovim.defaultEditor = true;
  programs.appimage.binfmt = true;

  # Nix configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.extraOptions = ''
    trusted-users = root ${user}
  '';

  system.stateVersion = "24.05";
}
