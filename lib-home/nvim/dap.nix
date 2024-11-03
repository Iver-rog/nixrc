{pkgs, ... }:
{
  programs.neovim = {
    extraPackages = with pkgs; [
    ];
    plugins = with pkgs.vimPlugins; [
      nvim-dap-ui
      nvim-dap
    ];
	#    extraConfig = '' 
	#      local dap = require('dap')
	#      dap.configurations.python = {
	#      {
	# type = 'python';
	# request = 'launch';
	# name = "Launch file";
	# program = "''\'''\${file}";
	# pythonPath = function()
	#   return '/usr/bin/python'
	# end;
	#      },
	#    }
	#    '';
  };
}
