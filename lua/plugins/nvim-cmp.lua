return {
  {
    'hrsh7th/nvim-cmp',
    lazy = false,
    event = 'LspAttach',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      {
        'saadparwaiz1/cmp_luasnip',
        dependencies = {
          'L3MON4D3/LuaSnip',
        },
      },
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
    },
    config = function()
      local lspkind = require('lspkind')
      local cmp = require'cmp'
      local luasnip = require'luasnip'
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          --['<C-b>'] = cmp.mapping.scroll_docs(-4),
          --['<C-f>'] = cmp.mapping.scroll_docs(4),
          --['<C-Space>'] = cmp.mapping.complete(),
          --['<C-e>'] = cmp.mapping.abort(),
          --['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

           ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'path' },
          { name = 'buffer' },
        }),
         window = {
          completion = {
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
            col_offset = -3,
            side_padding = 0,
            border = 'rounded',
            scrollbar = true,
          },
          documentation = {
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
            border = 'rounded',
            scrollbar = true,
          },
        },
            formatting = {
              format = lspkind.cmp_format({
                with_text = true, -- do not show text alongside icons
                maxwidth = 50,    -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                before = function(entry, vim_item)
                  -- Source 显示提示来源
                  vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                  return vim_item
                end
              })
            },


        experimental = {
          ghost_text = true,
        }

      })
    end
  }

}
