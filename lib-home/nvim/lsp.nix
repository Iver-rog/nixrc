{ pkgs , ... }:
{
  programs.neovim = {
    extraPackages = with pkgs; [
      clang-tools #c/c++
      pyright
    ];
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      #optional: nvim-cmp for autocompletion
      nvim-cmp
      cmp-nvim-lsp
      lspkind-nvim
    ];
    extraConfig = ''
      " Place your Neovim Lua configuration here
      lua << EOF
        -- Import the LSP config plugin
        local lspconfig = require('lspconfig')

        -- A list of language servers you want to automatically attach
        local servers = { 'pyright', 'tsserver', 'gopls', 'rust_analyzer', 'clangd' }

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
            ['<Esc>'] = cmp.mapping.abort(),
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
      EOF
    '';
  };
}
