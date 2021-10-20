-- General settings
vim.wo.wrap = false -- no wraping
vim.o.fileencoding = "utf-8"
vim.opt.fileformat = "unix"
vim.o.mouse = "a" -- enable mouse
vim.wo.number = true -- enable numbers
vim.o.clipboard = "unnamedplus" -- enable clipboard
vim.o.backup = false
vim.o.writebackup = false
vim.o.hidden = true
vim.cmd("set timeoutlen=600")

-- Indentation
vim.o.expandtab = true -- convert tabs to spaces
vim.o.autoindent = true -- tabs be smart?
vim.cmd("set smarttab")
vim.cmd("set ts=4") -- insert 4 spaces for tabs
vim.cmd("set sw=4")
vim.cmd("set undofile")

-- UI
vim.o.updatetime = 300
vim.o.showmode = false
vim.wo.cursorline = true
vim.o.termguicolors = true
vim.o.pumheight = 8
vim.o.showtabline = 2

-- Completion
vim.cmd("set shortmess+=c")

if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.g.sqlite_clib_path = join_paths(os.getenv('SCOOP'), "apps", "sqlite3dll", "current","sqlite3.dll")
end

vim.o.ignorecase = true
vim.o.smartcase = true
