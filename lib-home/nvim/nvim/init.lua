
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- No timeout for leader key
vim.o.timeout = false
vim.o.ttimeout = false

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between Os and Neovim.
-- vim.opt.clipboard = 'unnamedpluss'

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
vim.g.gruvbox_material_diagnostic_text_highlight = false
vim.g.gruvbox_material_diagnostic_line_highlight = false
vim.g.gruvbox_material_diagnostic_virtual_text = 'not grey' -- 'grey'
-- vim.g.gruvbox_material_foreground = 'hard'
-- vim.g.gruvbox_material_background = 'hard'
vim.cmd("colorscheme gruvbox-material")

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



require('telescope').setup {
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  }

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>s.', builtin.grep_string, { desc = '[S]earch [R]resent Files' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers'})


require'nvim-tree'.setup {}

-- Draws colored bars to indicate git changes
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

require('nvim-treesitter').setup{
  ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'query', 'vim', 'vimdoc', 'python', 'wgsl'},
  highlight = {
    enable = true,
  },
  indent = {enable = true},
}

vim.o.foldlevel = 99
vim.o.foldcolumn = '1'
vim.wo.foldnestmax = 1
vim.wo.foldminlines = 1
vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... ' . '(' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.wo.foldmethod = "syntax"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.cmd('highlight Folded ctermbg=NONE guibg=NONE')
vim.cmd('highlight FoldColumn ctermfg=NONE guifg=NONE')

require("lsp")
require("mini-nvim")
require("debugger")
