local uname = "Windows"

if vim.fn.has("unix") then
  uname = vim.fn.system("uname -s")
end

vim.opt.autoread = true

vim.g.mapleader = " "

vim.opt.title = true                        -- Set terminal title
vim.opt.ruler = true                        -- Show where you are
vim.opt.history = 500

-- Tab control
vim.opt.softtabstop = 2                     -- insert mode tab and backspace uses 2 spaces
vim.opt.shiftwidth = 2                      -- normal mode indentation commands uses 2 spaces
vim.opt.expandtab = true                    -- expand tabs to spaces
vim.opt.tabstop = 2                        -- actual tab uses 8 spaces

vim.opt.mouse = a                           -- click tabs, drag tabs, and drag split bars

vim.opt.clipboard:append({ "unnamedplus" }) -- yank and paste with the system clipboard

vim.opt.directory:remove({ "." })           -- don't store swapfiles in the current directory
vim.opt.list = true                         -- show trailing whitespace
vim.opt.listchars = { tab = "\\ \\", trail = '.', nbsp = '✦'  }
vim.opt.tabpagemax = 30
vim.opt.showcmd = true                      -- show current command going on

vim.opt.showtabline = 2

-- Code folding settings
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false                 -- Remove ugly folds
vim.opt.diffopt = "filler,context:9999"     -- nofold in diff mode

vim.opt.inccommand = "split"

vim.opt.wildmenu = true                     -- enhanced command line completion
vim.opt.wildmode= { list = "longest" , full = true }
vim.opt.wildignore:append({ "*.DS_Store" })
vim.opt.wildignore:append({ "*/_build**" })
vim.opt.wildignore:append({ "*/node_modules/**" })
vim.opt.wildignore:append({ "*/__snapshots__/**" })
vim.opt.wildignore:append({ "target/**" })
vim.opt.wildignore:append({ "+=tmp/**" });
vim.opt.hidden = true                        -- allow buffer to be hidden when writing to disk
vim.opt.scrolloff = 5                        -- show context above/below cursor line
vim.opt.shell = os.getenv("SHELL")

vim.opt.path:append({ "**" })                -- Search down into subfolders 

vim.opt.ignorecase = true                    -- case-insensitive search
vim.opt.smartcase = true                     -- case-sensitive search if any caps
vim.opt.hlsearch = true

vim.opt.showmatch = true                     -- highlight matching on {[()]}

-- Error bells
vim.opt.visualbell = true

vim.opt.showmode = false                     -- lightline is prettier, don't need this

vim.filetype:add({
  extension = {
    sh = "bash",
    json = "json",
    js = "javascript",
    jsx = "javascriptreact",
    ts = "typescript",
    tsx = "typescriptreact",
    lua = 'lua'
  },
  filename = {
   [".bash_profile"] = "bash",
   ["*.bashrc"] = "bash",
   ["*.zshrc"] = "zsh"
  }
})

-- Theme
vim.opt.number = true                      -- show the current line number

vim.opt.smartindent = true

vim.opt.swapfile = false        -- Don't make backups.

vim.opt.laststatus = 2      -- show the status line all the time

vim.opt.cmdheight = 2

vim.opt.signcolumn = yes

-- ===============================================================================
-- Vim Pack Config
-- ===============================================================================
require("bundles")

require("auto-dark-mode").setup()

vim.opt.termguicolors = true

-- ===============================================================================
-- Lightline Config
-- ===============================================================================
require("lightline")
