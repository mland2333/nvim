vim.api.nvim_create_autocmd('FileType', {
  pattern = 'verilog',    -- 针对 Verilog 文件
  callback = function()
    -- 设置单行注释样式
    vim.bo.commentstring = '/* %s */'
  end,
})
return{
  {
    'echasnovski/mini.comment',
    lazy = true,
    keys = { 'V', '<leader>cc' },
    opts = {
      mappings = {
        comment_line = '<leader>cc',
        comment_visual = '<leader>cc',
      }
    },
  }
}
