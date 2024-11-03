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
      ripgrep # needed dependency for treesitter nvim plugin
      # Formatters
      # LSP
      # rust
      # rust-analyzer
      # Tools

      # == LSP ==
      rust-analyzer
      nil # nix language server
      clang-tools #c/c++
      pyright
      sumneko-lua-language-server
    ];
  };
  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };
}
