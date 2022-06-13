-- ============================================================================== --
-- Options
-- ============================================================================== --

local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- indentation
local indent_width = 4
opt.tabstop = indent_width
opt.softtabstop = indent_width
opt.shiftwidth = indent_width
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true

-- Ignore search case until I use it
opt.smartcase = true
opt.smartindent = true

-- Undo file
opt.undofile = true

-- disable backup
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- other editor opts
opt.wrap = false
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.signcolumn = "yes"
opt.mouse = "a"
opt.splitright = true
opt.splitbelow = true
opt.hidden = false

-- ============================================================================== --
-- Plugins
-- ============================================================================== --

-- Setup plugin manager (packer.nvim)
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

pcall(require, "impatient")                 -- load lua modules faster

require("packer").startup(function()
    local use = require("packer").use
    use("wbthomason/packer.nvim")                                         -- Let packer manage itself

    use("numToStr/Comment.nvim")                                          -- Comments
    use({ "ThePrimeagen/harpoon", after = "plenary.nvim" })               -- Best markdown plugin
    use({"TimUntersberger/neogit", after = "plenary.nvim" })              -- magit in neovim ?

    -- LSP
    use("neovim/nvim-lspconfig")
    use("onsails/lspkind-nvim")
    use("j-hui/fidget.nvim")

    use("L3MON4D3/LuaSnip")                                               -- Snippets

    -- Completion
    use("hrsh7th/nvim-cmp")
    use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
    use({ "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } })

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- Debugging
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")

    use("b0o/SchemaStore.nvim")             -- JSON schemas
    use("saecki/crates.nvim")               -- Rust crates

    -- prettier
    use({ "prettier/vim-prettier",
        run = "yarn install --frozen-lockfile --production",
        ft = { "javascript", "typescript", "css", "less", "scss", "json", "graphql", "markdown", "vue", "svelte", "yaml", "html" },
    })

    -- Neovim stuff
    use("nvim-lua/plenary.nvim")                                          -- NeoVim Framework
    use("lewis6991/impatient.nvim")                                       -- load lua modules faster

    -- Colorscheme
    use("ellisonleao/gruvbox.nvim")

    -- AutoSync plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

-- ============================================================================== --
-- Config
-- ============================================================================== --

-- Remap <leader> -> <Space>
pcall(vim.keymap.del, "n", "<Space>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local set_keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

set_keymap("n", "gq", ":tabclose<CR>", opts)

set_keymap("n", "<leader>t", ":terminal<CR>", opts)
set_keymap("n", "<leader>e", ":Explore<CR>", opts)

set_keymap("n", "!", ":!", { noremap = true })
set_keymap("n", "?", ":nohlsearch<CR>", opts)

set_keymap("v", "<", "<gv", opts)
set_keymap("v", ">", ">gv", opts)
set_keymap("n", "<", "V<<ESC>", opts)
set_keymap("n", ">", "V><ESC>", opts)

-- better escape
set_keymap("i", "<C-c>", "<ESC>", opts)
set_keymap("v", "<C-c>", "<ESC>", opts)
set_keymap("n", "<C-c>", "<ESC>", opts)

-- Setup Plugins
require("Comment").setup()
require("fidget").setup()

-- My languages setup
require("c")
require("go")
require("rust")
require("JS")

-- This is my custom status line
-- it lists harpoon marks on the statusline
-- works like tabs but better
opt.statusline = " %{%v:lua.require'statusline'.gen()%} "
opt.laststatus = 3

-- Autosave
local group = vim.api.nvim_create_augroup("AutoSave", { clear = true })
vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
    group = group,
    callback = function ()
        if vim.fn.filewritable(vim.fn.bufname()) == 1 then
            vim.cmd("write")
        end
    end
})

-- Colorscheme
vim.cmd("colorscheme gruvbox")
