require('options')
require('keymaps')
require('plugins')
require('colorscheme')
require('lsp')
require('device')

--load last session of current directory
require("persistence").load()
