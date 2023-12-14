-- Use vim.loop to get the hostname
local hostname = vim.fn.hostname()

local M = {}

M.isLaptop = hostname == '?'
M.isDesktop = hostname == 'archlinux'

return M
