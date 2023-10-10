-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

vim.g.mapleader = " "    -- use space as leader key

-- Shorter function call
local keymap = vim.api.nvim_set_keymap


-----------------
-- Normal mode --
-----------------
-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fn", "<cmd>Telescope lsp_document_symbols<cr>", opts)
-- Open file tree
keymap("n", "<leader>e", "<cmd> NvimTreeToggle <CR>", opts)
-- bufferline cycle
-- keymap("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>", opts)
-- keymap("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>", opts)
-- comment toggle
vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end)

-----------------
-- Visual mode --
-----------------

-- pase without loosing
keymap("x", "<leader>p", [["_dP]], opts)
-- delete to void/don't copy
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
-- comment toggle
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")



---------------
-- Hard mode --
---------------
local hardmode = true
if hardmode then
    -- Show an error message if a disabled key is pressed
    local msg = [[<cmd>echohl Error | echo "KEY DISABLED" | echohl None<CR>]]

    -- Disable arrow keys in insert mode with a styled message
    vim.api.nvim_set_keymap('i', '<Up>', '<C-o>' .. msg, { noremap = true, silent = false })
    vim.api.nvim_set_keymap('i', '<Down>', '<C-o>' .. msg, { noremap = true, silent = false })
    vim.api.nvim_set_keymap('i', '<Left>', '<C-o>' .. msg, { noremap = true, silent = false })
    vim.api.nvim_set_keymap('i', '<Right>', '<C-o>' .. msg, { noremap = true, silent = false })
    vim.api.nvim_set_keymap('i', '<Del>', '<C-o>' .. msg, { noremap = true, silent = false })
    vim.api.nvim_set_keymap('i', '<BS>', '<C-o>' .. msg, { noremap = true, silent = false })

    -- Disable arrow keys in normal mode with a styled message
    vim.api.nvim_set_keymap('n', '<Up>', msg, { noremap = true, silent = false })
    vim.api.nvim_set_keymap('n', '<Down>', msg, { noremap = true, silent = false })
    vim.api.nvim_set_keymap('n', '<Left>', msg, { noremap = true, silent = false })
    vim.api.nvim_set_keymap('n', '<Right>', msg, { noremap = true, silent = false })
    vim.api.nvim_set_keymap('n', '<BS>', msg, { noremap = true, silent = false })
end
