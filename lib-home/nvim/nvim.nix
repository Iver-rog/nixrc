{ pkgs, ... }:
{
  imports = [
    ./lsp.nix
    ./dap.nix
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-tmux-navigator
      nvim-treesitter.withAllGrammars
      gruvbox-material
      which-key-nvim
      telescope-nvim
      nvim-tree-lua
      gitsigns-nvim
    ];

    extraPackages = with pkgs; [
    wl-clipboard
      # Formatters
      # LSP
      # rust
      # rust-analyzer
      # Tools
    ];
  };
  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };
}
