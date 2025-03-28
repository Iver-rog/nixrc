# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./vm.nix
      ./tor.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "nb_NO.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "no";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # Enable bluetooth.
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    # config = {
    #   default = "kde";
    # };
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  # config.cudaSupport = true;

  hardware.openrazer.enable = true;
  
  services.solaar.enable = true;

  users.users.iver = {
    isNormalUser = true;
    description = "Iver Rogstadkjernet";
    extraGroups = [ "networkmanager" "wheel" "openrazer" ];
    packages = with pkgs; [
      zotero
      audacity
      firefox
      thunderbird
      freecad-wayland
      vlc
      libreoffice-qt6-fresh
      blender
      gimp
      darktable
      chromium
      joplin-desktop
      maestral-gui #Dropbox client
      mediawriter
      inkscape
      orca-slicer
      octave
      teams-for-linux
      resources
      paraview
      localsend
      transmission_4-qt
      calibre
      # Terminal programs
      tldr
      renameutils
      cloc
      lsd
      gh
      ripgrep # needed dependency for treesitter nvim plugin
      btop
      neovim
      tmux
      bat
      entr
      distrobox
      git-credential-manager
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        vadimcn.vscode-lldb
        # jnoortheen.nix-ide
        mkhl.direnv
        ms-python.python
        vscodevim.vim
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        ms-vscode.hexeditor
        ms-python.debugpy
        # ms-pyright.pyright
      # ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      #   {
      #     name = "remote-ssh-edit";
      #     publisher = "ms-vscode-remote";
      #     version = "0.47.2";
      #     sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      #   }
      ];
    })
    ];
  };
  
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "iver" = import ./home.nix;
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    kdePackages.partitionmanager
    polychromatic
    openrazer-daemon
    neovim 
    tmux
    wget
    git
    nixfmt
    quickemu
    unzip
    gnuplot
    devenv
    trash-cli
  ];

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  programs.neovim.defaultEditor = true;

  programs.appimage.binfmt = true;

   nix.extraOptions = ''
        trusted-users = root iver
    '';


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
