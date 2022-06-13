package.loaded["gruvbox"] = nil
package.loaded["gruvbox.base"] = nil
package.loaded["gruvbox.plugins"] = nil
package.loaded["gruvbox.lightline"] = nil
package.loaded["gruvbox.languages"] = nil

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = " " }

require("gruvbox").load()

vim.cmd("highlight CursorLine guibg=NONE")
vim.cmd("highlight CursorLineNr guibg=NONE")
vim.cmd("highlight SignColumn guibg=NONE")
