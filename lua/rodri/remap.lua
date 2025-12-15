vim.g.mapleader = " "
vim.keymap.set("n", "<leader>vv", vim.cmd.Ex)
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>pp", '"+p')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
