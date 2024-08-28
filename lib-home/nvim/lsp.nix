{ pkgs , ... }:
{
  programs.neovim = {
    extraPackages = with pkgs; [
      clang-tools #c/c++
      rnix-lsp #nix
      nodePackages.pyright #python
    ];
    plugins = with pkgs.vimPlugins; [
              {
            # ==================================================
            # LSP configuration
            # ==================================================
            # This plugin is used for configuring and managing connections to language servers in Neovim.
            # While LSP support is indeed a part of Neovim's core, nvim-lspconfig is used to streamline and
            # customize the configuration for different language servers.
            #
            # It can work with language servers installed by Mason or with servers installed manually by
            # the user (e.g. using apt install or other package managers such as nix in this case).
            #
            # As I am using nix to intall my langage servers I don't need
            # to use mason to install them and mason-lspcofnig to allow nvim-lspconfig
            # to configre the langage servers installed by mason.
            #
            # This plugin "output" needs to be "piped" itno a completion framework
            # to be useful to the user.
            #
            # In this case it is "piped" by cmp-nvim-lsp to nvim-cmp completion
            # framework.
            plugin = nvim-lspconfig;
            type = "lua";
            config = ''
                local opts = { noremap=true, silent=true }

                -- Use an on_attach function to only map the following keys
                -- after the language server attaches to the current buffer
                local on_attach = function(client, bufnr)

                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap=true, silent=true, buffer=bufnr }

                -- go to definition.
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, bufopts)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, bufopts)
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
                -- clang-tidy code actions
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, bufopts)
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, bufopts)
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, bufopts)
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, bufopts)

                -- Can be used to replace plugin trouble-nvim(and dependencie nvim-web-devicons)
                vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

                -- clang format.
                vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
                end

                local lsp_flags = {
                    -- This is the default in Nvim 0.7+
                        debounce_text_changes = 150,
                }

                -- cmp-nvim completion framework specifics
                local capabilities = require('cmp_nvim_lsp').default_capabilities()

                local function setup_lsp_server(server_name)
                    local setup_table = {
                        on_attach = on_attach,
                        flags = lsp_flags,
                        capabilities = capabilities,
                    }
                    -- Fix for warning multiple different client offset encodings detected for buffer this is not support ed yet
                    if server_name == 'clangd' then
                        setup_table.cmd = { 'clangd', '--offset-encoding=utf-16' }
                    else
                        setup_table.cmd = nil
                            end
                    require('lspconfig')[server_name].setup(setup_table)
                    -- ------------
                end

                setup_lsp_server('lua_ls')
                setup_lsp_server('clangd')
                setup_lsp_server('pyright')
            '';
          }
    ];
  };
}
