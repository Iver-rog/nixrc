{ pkgs, ... }:
{
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

      # == LSP ==
      nvim-lspconfig
      # optional: nvim-cmp for autocompletion
      nvim-cmp
      cmp-nvim-lsp
      lspkind-nvim
      # Useful status updates for LSP
      fidget-nvim

      # == debugging ==
      nvim-dap-ui
      nvim-dap
    ];

    extraPackages = with pkgs; [
    wl-clipboard
      # Formatters
      # LSP
      # rust
      # rust-analyzer
      # Tools

      # == LSP ==
      clang-tools #c/c++
      pyright
    ];
  };
  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };
}
