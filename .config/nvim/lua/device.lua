-- Use vim.loop to get the hostname
local hostname = vim.fn.hostname()

local M = {}

M.isLaptop = hostname == 'fedora-box'
M.isDesktop = hostname == 'archlinux'

return M
