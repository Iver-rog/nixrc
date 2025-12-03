{ config, pkgs, user,... }:{

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  # networking.networkmanager.wifi.backend = "iwd";
  security = {
    pam = {
      services = {
        # ${userSettings.username} = {
        ${user} = {
        kwallet = {
          enable = true;
          package = pkgs.kdePackages.kwallet-pam;
          };
        };
      };
    };
  };
  security.pam.services.hyprland.enableKwallet = true;

  environment.systemPackages = with pkgs; [
    waybar
    pwvucontrol # sound control
    dunst # notification daemon
    blueman
    libnotify
    brightnessctl
    playerctl
    # networkmanagerapplet

    hyprpaper
    hyprsunset
    rofi-wayland
    hyprpicker
    gnome-icon-theme
    # kdePackages.kwallet-pam
  ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
}

