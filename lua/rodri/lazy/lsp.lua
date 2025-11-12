return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "eslint",
                },
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
                end
            })
        end,
    }
}
