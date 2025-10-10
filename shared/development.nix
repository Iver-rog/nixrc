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
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        vadimcn.vscode-lldb
        mkhl.direnv
        ms-python.python
        vscodevim.vim
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        ms-vscode.hexeditor
        ms-python.debugpy
      ];
    })

    # Terminal utilities for development
    ripgrep
    bat
    yazi
    tldr
    renameutils
    cloc
    lsd
    btop
    entr
    wget
    unzip
    trash-cli

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