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
      mini-nvim # [S]elect [a]round [(] pattern

      # == LSP ==
      nvim-lspconfig
      lspkind-nvim
      # Useful status updates for LSP
      fidget-nvim

      # == Auto Complete ==
      nvim-cmp
      lazydev-nvim
      cmp-nvim-lsp
      cmp_luasnip
      cmp-path
      luasnip

      # == debugging ==
      nvim-dap-ui
      nvim-dap
    ];

    extraPackages = with pkgs; [
      wl-clipboard
      ripgrep # needed dependency for treesitter nvim plugin

      # == LSP ==
      rust-analyzer
      nil # nix language server
      clang-tools #c/c++
      pyright
      sumneko-lua-language-server

      vscode-extensions.vadimcn.vscode-lldb
    ];
  };
  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };
}
