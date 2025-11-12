return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            --vim.lsp.config("lua_ls", {})
            --vim.lsp.enable("lua_ls")
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                },
            })
            --vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references())
            vim.diagnostic.config({virtual_text = true})
        end,
    }
}
