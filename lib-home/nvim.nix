{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      gruvbox-material
    ];
    extraPackages = with pkgs; [
      # Formatters
      # LSP
      rust-analyzer
      # Tools
    ];
  };
}
