return {
   {
    'folke/flash.nvim',
    lazy = true,
    opts = {},
    keys = {
      {
        '<c-j>',
        mode = 'n',
        function()
          require('flash').jump()
        end,
        desc = 'Flash'
      },
    },
  }
}
