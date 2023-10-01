local M = {}

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
-- This configuration, which allows both mason and rust-tools originally comes from 
-- https://github.com/Gremious/configs/blob/7811525b4c32919f820a758c11c7eb2dc999cfa8/lua/config/lsp.lua
M.config = {
    inlay_hints = {
        auto = true,
    },
    server = {
        standalone = false,
    },
    dap = function()
        local mason_registry = require("mason-registry")

        local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
        local codelldb_path = codelldb_root .. "adapter/codelldb"
        local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"

        return {
            adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
        }
    end,
}

M.plugins = {
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function ()
            vim.g.rustfmt_autosave = 1
        end
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = "neovim/nvim-lspconfig",
    },
    {
        'saecki/crates.nvim',
        ft = {"toml"},
        config = function(_, opts)
            local crates  = require('crates')
            crates.setup(opts)
            require('cmp').setup.buffer({
                sources = { { name = "crates" }}
            })
            crates.show()
        end,
    }
}

return M
