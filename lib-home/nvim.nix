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
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-tmux-navigator
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      gruvbox-material
      vim-nix
      # { # Useful plugin to show you pendig keybinds.
      #   plugin = which-key-nvim;
      #   type = "lua";
      #   config = ''
      #     require('which-key').setup()
      #
      #     -- Document existing key chains
      #     require('whitch-key').add {
      #       { '<leader>c, group = '[C]ode'},
      #       { '<leader>d, group = '[D]ocument'},
      #       { '<leader>r, group = '[R]rename'},
      #       { '<leader>s, group = '[S]earch'},
      #       { '<leader>w, group = '[W]orkspace'},
      #       { '<leader>t, group = '[T]oggle'},
      #       { '<leader>h, group = 'Git [H]unk', mode = { 'n', 'v'} },
      #     }
      #   '';
      # }

      {
          # A tree file explore.
          plugin = nvim-tree-lua;
          type = "lua";
          config = ''
          require'nvim-tree'.setup {}
          '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
          require('gitsigns').setup {
            on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
              vim.keymap.set('n', "<leader>gd", gs.reset_hunk)
              vim.keymap.set('v', "<leader>gd", function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
              vim.keymap.set('n', "<leader>gb", gs.toggle_current_line_blame)
              vim.keymap.set('n', "]g", function()
                 if vim.wo.diff then return ']c' end
                 vim.schedule(function() gs.next_hunk() end)
                 return '<Ignore>'
                 end, {expr=true})
               vim.keymap.set('n', "[g", function()
                 if vim.wo.diff then return '[c' end
                 vim.schedule(function() gs.prev_hunk() end)
                 return '<Ignore>'
                 end, {expr=true})
            end
            }
        '';
      }
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
     extraLuaConfig = ''
        -- ============
        -- Editor setup
        -- ============
        vim.g.mapleader = ' '
        vim.g.maplocalleader = ' '

        -- No timeout for leader key
        vim.o.timeout = false
        vim.o.ttimeout = false

        -- Enable mouse mode
        vim.opt.mouse = 'a'
        
        -- Don't show the mode, since it's already in the status line
        vim.opt.showmode = false
        
        -- Sync clipboard between Os and Neovim.
        --vim.opt.clipboard = 'unnamedpluss'

        -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
        vim.opt.ignorecase = true
        vim.opt.smartcase = true

        -- Keep signcolumn on by default
        vim.opt.signcolumn = 'yes'
        
        -- Preview substitutions live, as you type!
        vim.opt.inccommand = 'split'
        
        -- Show which line number your cursor is on
        vim.opt.cursorline = true
        
        -- Minimal number of screen lines to keep above and below the cursor
        vim.opt.scrolloff = 10

        -- Set highlight on search, but clear on pressing <Esc> in normal mode
        vim.opt.hlsearch = true
        vim.keymap.set('n', '<Esc>', '<cmd>noholsearch<CR>')

        -- Colorscheme
        vim.cmd("colorscheme gruvbox-material")
        vim.g.have_nerd_font = true

        -- Line numbers and relative lines
        vim.opt.number = true
        -- vim.opt.relativenumber = true

        -- Indentation settings of 2 spaces
        vim.o.tabstop = 2
        vim.o.softtabstop = 2
        vim.o.shiftwidth = 2
        vim.o.expandtab = true

        -- Use file type based indentation
        vim.cmd("filetype plugin indent on")

        vim.api.nvim_create_autocmd('TextYankPost', {
          desc = 'Highlight when yanking (copying) text',
          group = vim.api.nvim_create_augroup('Kickstart-highlight-yank', { clear = true }),
          callback = function()
            vim.highlight.on_yank()
          end,
        })
    
       -- NvimTree toggle
       vim.keymap.set('n', '\\', ":NvimTreeToggle<Cr>", opts)
    
       -- Apply lsp server formating
       vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, opts)
	'';
  };
}
