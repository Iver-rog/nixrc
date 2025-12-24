{ config, pkgs, user,... }:{

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

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
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
}

