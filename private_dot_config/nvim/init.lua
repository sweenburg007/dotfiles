-- Stephen Sweeney's init.lua (for Neovim)

-- install plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

if vim.fn.exists("g:vscode") ~= 1 then
    require("lazy").setup("plugins")
    require "core.options"
    require "core.autocmds"
    require "core.mappings"

else
    require("lazy").setup("vscode.plugins")
    require "vscode.core.mappings"
end
