{ pkgs , ... }:
{
  programs.neovim = {
    extraPackages = with pkgs; [
      clang-tools #c/c++
      pyright
    ];
    plugins = with pkgs.vimPlugins; [
          {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
        require'lspconfig'.pyright.setup{}
   
        '';
      }
    ];
  };
}
