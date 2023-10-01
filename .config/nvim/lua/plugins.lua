-- load lazy as package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- UI/Theming
  { "arcticicestudio/nord-vim" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = function()
      return require "config.lualine"
    end,
  },
  -- Editing
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = function()
      require("ibl").setup(
      {
          indent = { char = "▏" },
          scope = { show_start = false, show_end = false },
      }
      )
    end,
  },
  { "numToStr/Comment.nvim" },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function()
      return require("config.others").autopair
    end,
  },
  -- file management
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "config.nvimtree"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    opts = function()
      return require "config.telescope"
    end,
  },

  -- git
   {
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    -- config from NVChad
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    opts = function()
      return require("config.others").gitsigns
    end,
  },

  -- debugging
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      require("config/debugging").setup()
    end,
  },

  -- lsp 
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  --   event = { "BufReadPre", "BufNewFile" },
  --   opts = function()
  --     return require "config.treesitter"
  --   end,
  -- },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    config = function()
      require("mason").setup()
    end,
  },
  {
   "williamboman/mason-lspconfig.nvim",
      opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer"
      }
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end
  },
  { "neovim/nvim-lspconfig" },

  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("config.others").luasnip(opts)
        end,
      },
      -- cmp sources plugins
      {
        "onsails/lspkind.nvim",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "config.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  require("languages.rust").plugins,
}

-- load plugins
require("lazy").setup(plugins, require('config.lazy_nvim'))
