-- Useful status updates for LSP
require('fidget').setup({})

local lspconfig = require('lspconfig')

-- A list of language servers you want to automatically attach
local servers = { 'pyright', 'rust_analyzer', 'clangd', 'nil_ls' }

-- Loop through each language server and set up its default configuration
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    end,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- nvim-cmp setup for completion
local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users
    end,
  },
  mapping = {
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = true, maxwidth = 50 })
  }
})

-- Set up LSP capabilities with `nvim-cmp`
local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end
-- The following code creates a keymap to toggle inlay hints in your
-- code, if the language server you are using supports them
if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
  map('<leader>th', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
  end, '[T]oggle Inlay [H]ints')
end
