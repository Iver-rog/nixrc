{ pkgs , ... }:
{
  programs.neovim = {
    extraPackages = with pkgs; [
      clang-tools #c/c++
    ];
    plugins = with pkgs.vimPlugins; [
          {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''

        '';
      }
    ];
  };
}
