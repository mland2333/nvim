return {
  {
    'nvimdev/guard.nvim',
    lazy = true,
    event = 'LspAttach',
    dependencies = {
      'nvimdev/guard-collection',
    },
    config = function()
      local ft = require('guard.filetype')
      ft('c', 'cpp'):fmt('clang-format')
      ft('python'):fmt('black')
      ft('lua'):fmt('lsp')
      require('guard').setup({
        fmt_on_save = false,
        lsp_as_default_formatter = true,
        vim.keymap.set({ 'n', 'v' }, '<leader>f', '<cmd>GuardFmt<CR>', {}),
      })
    end
  }
}
