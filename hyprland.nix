{ config, pkgs, ... }:{

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  # networking.networkmanager.wifi.backend = "iwd";

  environment.systemPackages = with pkgs; [
    waybar
    pwvucontrol # sound control
    dunst
    libnotify
    brightnessctl
    playerctl
    networkmanagerapplet

    hyprpaper
    hyprsunset
    rofi-wayland
    hyprpicker
  ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
}

