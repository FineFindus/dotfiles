-- Lsp server name .
local function lsp()

  return {
    function()
      local msg = "No Active Lsp"
      local ft = vim.bo.filetype
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return msg
      end

      local clients_output = {}
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, ft) ~= -1 then
          table.insert(clients_output, client.name)
        end
      end

      if #clients_output > 0 then
        return table.concat(clients_output, "/")
      else
        return msg
      end
    end,
    icon = "  LSP ~",
    color = { gui = "bold" },
  }
end

return {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '|',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {'branch', 'diff', 'diagnostics'},
    lualine_x = {lsp()},
    lualine_y = {'fileformat', 'filetype'},
    lualine_z = {'progress'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

