{ pkgs, ... }:

{
  # Core development tools
  packages = with pkgs; [
    # Editors and development environment
    # neovim - handled by lib-home/nvim/nvim.nix
    # tmux - handled by lib-home/tmux.nix
    git
    gh
    nixfmt-classic
    devenv
    git-credential-manager
    claude-code

    # Terminal utilities for development
    ripgrep
    bat
    tldr
    renameutils
    cloc
    lsd
    btop
    wget
    unzip
    trash-cli
    entr

    # Container and virtualization tools
    distrobox
  ];

  # Development-related system packages (for NixOS environment.systemPackages)
  systemPackages = with pkgs; [
    alacritty
    wget
    git
    nixfmt-classic
    unzip
    gnuplot
    devenv
    trash-cli
  ];
}
