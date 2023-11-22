-- Use vim.loop to get the hostname
local hostname = vim.fn.hostname()

local M = {}

M.isLaptop = string.find(hostname, '?')
M.isDesktop = string.find(hostname, 'archlinux')

return M
