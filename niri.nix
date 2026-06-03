{ config, pkgs, user,... }:{

  programs.niri= {
    enable = true;
    # withUWSM = true;
    # xwayland.enable = true;
  };

  services.dbus.enable = true;
  programs.dconf.enable = true;

  xdg.portal.config.niri = {
    "org.freedesktop.impl.portal.FileChooser" = [ "kde" ]; # or "gtk"
  };


  environment.systemPackages = with pkgs; [
    xwayland-satellite
    waybar
    pwvucontrol # sound control
    dunst # notification daemon
    blueman
    libnotify
    brightnessctl
    playerctl
    # networkmanagerapplet
    loupe # immage viewer
    sunsetr # blue light filter

    #screenshot
    grim
    slurp
    wl-clipboard-rs

    rofi
    gnome-icon-theme
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
}

