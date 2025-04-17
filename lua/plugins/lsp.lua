return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
      "nvimdev/lspsaga.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lsp = {
        'lua_ls',
        'jdtls',
        'pyright',
        'gopls',
        'clangd',
        'texlab',
        'html',
        'texlab',
        'cmake',
        'sqlls',
        -- 'typst_lsp',
        -- 'bufls',
        'rust_analyzer',
        'eslint',
        'asm_lsp',
        'tailwindcss',
        'ltex',
        'glsl_analyzer',
        'verible',
      }
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
      require("mason-lspconfig").setup {
        ensure_installed = lsp,
      }
       local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>d', '<cmd>Lspsaga peek_definition<CR>', 'Peek Definition')
        nmap('<leader>pr', '<cmd>Telescope lsp_references<CR>', 'Peek References')
        nmap('<c-k>', '<cmd>Lspsaga hover_doc<CR>', 'Hover Documentation')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
        nmap('<leader>wl', function()
          vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'Workspace List Folders')
        nmap('<leader>rn', '<cmd>Lspsaga rename ++project<cr>', 'Rename')
        nmap('<leader>ca', '<cmd>Lspsaga code_action<CR>', 'Code Action')
        nmap('<leader>ot', '<cmd>Lspsaga outline<CR>', 'OutLine') 
        nmap('d[', vim.diagnostic.goto_prev, 'Diangostics Prev')
        nmap('d]', vim.diagnostic.goto_next, 'Diangostics Next')
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      for _, v in ipairs(lsp) do
        require('lspconfig')[v].setup(vim.tbl_deep_extend('keep', {
          on_attach = on_attach,
          capabilities = capabilities,
        },{}))
      end
      require('lspsaga').setup({
        outline = {
          keys = {
            --quit = 'Q',
            toggle_or_jump = '<cr>',
          }
        },
        finder = {
          keys = {
            --quit = 'Q',
            edit = '<C-o>',
            toggle_or_open = '<cr>',
          },
        },
        definition = {
          keys = {
            edit = '<C-o>',
            vsplit = '<C-v>',
          }
        },
        code_action = {
          keys = {
            --quit = 'Q',
          }
        },
      })
    end
  }
}
