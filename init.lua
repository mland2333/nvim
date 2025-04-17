require("basic")

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

require("lazy").setup({
  spec = {
    { import = "plugins"},
  },
})
--theme
vim.o.background = "dark" -- or "light" for light mode
vim.opt.termguicolors = true
vim.cmd([[colorscheme gruvbox]])
        --require("plugins")
        --require('plugins.nvim-tree'),
        --require("lsp"),
        --require('plugins.nvim-treesitter'),
