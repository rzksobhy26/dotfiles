-- Some options I prefer
local opt = vim.opt
opt.cursorline = true
opt.termguicolors = true
opt.fillchars = { eob = " " }
opt.laststatus = 3

local c = {
    none = "NONE",
    fg = "#ebdbb2",
    bg = "#282828",

    red = "#cc241d",
    black = "#282828",
    green = "#98971a",
    yellow = "#d79921",
    blue = "#458588",
    magenta = "#b16286",
    cyan = "#689d6a",
    white = "#a89984",
    gray = "#a89984",

    blue0 = "#",
    yellow0 = "#fabd2f",

    visual_bg = "#665c54",
}

local groups = {
    LineNr = { guifg = "#7c6f64" },
    Normal = { guifg = c.fg, guibg = c.bg },
    SignColumn = { guibg = c.bg },
    Comment = { guifg = c.gray },
    TSComment = { guifg = c.gray },
    Todo = { guifg = c.fg, guibg = c.yellow, font = "bold," },
    TSTodo = { guifg = c.fg, guibg = c.yellow, font = "bold," },

    CursorLine = { guibg = c.none },
    CursorLineNr = { guifg = c.yellow0 },

    Search = { guibg = c.yellow0 },
    Visual = { guibg = c.visual_bg },

    Directory = { font = "bold," },

    WinSeparator = { guibg = c.none, guifg = c.fg },
}

for group, hls in pairs(groups) do
    local cmd = string.format("highlight %s ", group)

    for hl, val in pairs(hls) do
        cmd = cmd .. hl .. "=" .. val .. " "
    end

    vim.cmd(cmd)
end
