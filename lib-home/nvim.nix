{ pkgs, ... }:
let 
  myConfig = pkgs.vimUtils.buildVimPlugin {
    name = "iver-lua-config";
    src = ./nvim;
  };
# let
#   myConfig = pkgs.neovim.override {
#     configure = {
#       customRc = ''
#       :colorscheme evening
#       lua require("init")
#       '';
#       packages.myPlugins = with pkgs.vimPlugins; {
#       start = [
#         vim-go
#         MyConfig
#       ];
#       opt = [];
#       };
#     };
#   };
# in
#   with pkgs;
#   pkgs.mkShell {
#     buildInputs = [
#     myNeovim
#     ];
#   }
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-tmux-navigator
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      gruvbox-material
    ];
    extraPackages = with pkgs; [
      # Formatters
      # LSP
      # rust
      # rust-analyzer
      # Tools
    ];
      # ustomRC = ''
      #   luafile ${./nvim/init.lua}
      # '';
  };
}
