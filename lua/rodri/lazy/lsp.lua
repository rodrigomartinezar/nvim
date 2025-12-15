return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
        },
        config = function()
            require("fidget").setup({})
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "eslint",
                    "gopls",
                },
            })
            local cmp = require("cmp")
            local cmp_select = {behavior = cmp.SelectBehavior.Select}
            cmp.setup({
              snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                  require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                  -- For `mini.snippets` users:
                  -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
                  -- insert({ body = args.body }) -- Insert at cursor
                  -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
                  -- require("cmp.config").set_onetime({ sources = {} })
                end,
              },
              mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-a>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
              }),
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
              }, {
                { name = 'buffer' },
              })
            })
            local diagnosticConfig = {
                virtual_text = true,
            }
            vim.diagnostic.config(diagnosticConfig)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local bufnr = ev.buf
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
                    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
                    vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition)
                    vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation)
                end
            })
            vim.api.nvim_create_autocmd("BufWritePost", {
              callback = function ()
                vim.lsp.buf.format({ async = true }) 
              end
            })
        end,
    }
}
