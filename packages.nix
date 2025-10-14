{ pkgs, ... }:

{
  # Personal applications and tools
  packages = with pkgs; [
    # Browsers and communication
    firefox
    thunderbird
    chromium

    # Media and entertainment
    vlc
    audacity

    # Productivity and office
    libreoffice-qt6-fresh
    joplin-desktop
    zotero
    calibre

    # Creative and design tools
    freecad-wayland
    blender
    gimp3
    darktable
    inkscape

    # File sharing and utilities
    maestral-gui  # Dropbox client
    mediawriter
    localsend
    transmission_4-qt

    # Scientific and analysis
    octave
    paraview

    # 3D printing
    orca-slicer

    # System monitoring
    resources
  ];

  # Personal system packages (for NixOS environment.systemPackages)
  systemPackages = with pkgs; [
    kdePackages.partitionmanager
    polychromatic
    openrazer-daemon
    quickemu
  ];
}
