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
        'rust_analyzer',
        'tailwindcss',
        'ltex',
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
        -- 定义一个全局变量来记录开关状态
        local auto_hover_enabled = false
        -- 创建一个专用的自动命令组，防止冲突
        local auto_hover_group = vim.api.nvim_create_augroup("LspAutoHover", { clear = true })

        -- 定义开关函数
        local function toggle_auto_hover()
          if auto_hover_enabled then
            -- 关闭自动悬停
            vim.api.nvim_clear_autocmds({ group = auto_hover_group })
            vim.opt.updatetime = 4000 -- 恢复默认的 4秒 (或者你喜欢的其他值)
            auto_hover_enabled = false
            vim.notify("自动悬停文档: 已关闭", vim.log.levels.INFO)
          else
            -- 开启自动悬停
            vim.opt.updatetime = 500 -- 设置延迟为 500ms (0.5秒)，你可以根据需要调整
            vim.api.nvim_create_autocmd("CursorHold", {
              group = auto_hover_group,
              callback = function()
                -- 只有在 Normal 模式下且有 LSP 服务时才触发
                local ft = vim.bo.filetype
                if vim.fn.mode() == 'n' and ft ~= 'TelescopePrompt' and ft ~= 'lspsagaoutline' then
                  -- 使用 pcall 防止在没有 LSP 的地方报错
                  pcall(vim.cmd, "Lspsaga hover_doc")
                end
              end,
            })
            auto_hover_enabled = true
            vim.notify("自动悬停文档: 已开启 (延迟 0.5s)", vim.log.levels.INFO)
          end
        end
        -- 注册快捷键：<leader>ah (Auto Hover)
        nmap('<leader>ah', toggle_auto_hover, 'Toggle Auto Hover')
        -- 查看函数定义
        nmap('<leader>d', '<cmd>Lspsaga peek_definition<CR>', 'Peek Definition')
        -- 查看函数在哪里被调用了
        nmap('<leader>pr', '<cmd>Telescope lsp_references<CR>', 'Peek References')
        -- 悬停文档
        nmap('<c-k>', '<cmd>Lspsaga hover_doc<CR>', 'Hover Documentation')
        -- 智能重命名
        nmap('<leader>rn', '<cmd>Lspsaga rename ++project<cr>', 'Rename')
        -- 代码操作（万能修复键）
        nmap('<leader>ca', '<cmd>Lspsaga code_action<CR>', 'Code Action')
        -- 代码大纲
        nmap('<leader>ot', '<cmd>Lspsaga outline<CR>', 'OutLine')
        -- 跳转到上一个报错/警告
        nmap('d[', vim.diagnostic.goto_prev, 'Diangostics Prev')
        -- 跳转到下一个报错/警告
        nmap('d]', vim.diagnostic.goto_next, 'Diangostics Next')
        -- 跳转到定义 (最常用)
        nmap('gd', vim.lsp.buf.definition, 'Go to Definition')
        -- 跳转到声明 (C/C++ 头文件有用)
        nmap('gD', vim.lsp.buf.declaration, 'Go to Declaration')
        -- 跳转到实现 (接口 -> 实现类)
        nmap('gi', vim.lsp.buf.implementation, 'Go to Implementation')
        -- 跳转到类型定义 (例如 TypeScript 中查看 interface)
        nmap('gy', vim.lsp.buf.type_definition, 'Go to Type Definition')
        -- 代码格式化
        nmap('<leader>fi', function()
          vim.lsp.buf.format({ async = true })
        end, 'Format Code')
        -- LSP Finder, 显示定义、引用和实现
        nmap('gh', '<cmd>Lspsaga finder<CR>', 'Lsp Finder')
        -- 当前光标这行具体的报错信息
        nmap('<leader>sl', '<cmd>Lspsaga show_line_diagnostics<CR>', 'Show Line Diagnostics')
        -- 或者光标处的诊断
        nmap('<leader>sc', '<cmd>Lspsaga show_cursor_diagnostics<CR>', 'Show Cursor Diagnostics')
        -- 谁调用了这个函数
        nmap('<leader>ci', '<cmd>Lspsaga incoming_calls<CR>', 'Incoming Calls')
        -- 这个函数调用了谁
        nmap('<leader>co', '<cmd>Lspsaga outgoing_calls<CR>', 'Outgoing Calls')
        -- 查看当前文件的所有诊断
        nmap('<leader>dd', '<cmd>Telescope diagnostics bufnr=0<CR>', 'Document Diagnostics')
        -- 查看整个项目的所有诊断
        nmap('<leader>dw', '<cmd>Telescope diagnostics<CR>', 'Workspace Diagnostics')
        -- 在代码行内显示变量类型或参数名
        nmap('<leader>ih', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, 'Toggle Inlay Hints')
        -- 搜索整个项目中的函数、类、变量
        nmap('<leader>ws', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', 'Workspace Symbols')
        -- 重启 LSP 服务 (万能重启键)
        nmap('<leader>lr', '<cmd>LspRestart<CR>', 'Lsp Restart')
        -- 浮动终端 (可以在里面跑编译命令等)
        nmap('<A-d>', '<cmd>Lspsaga term_toggle<CR>', 'Toggle Float Terminal')
      end
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or not client.server_capabilities.documentHighlightProvider then
            return
          end

          local bufnr = args.buf
          local last_word = nil

          -- 光标停顿时高亮
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
              last_word = vim.fn.expand("<cword>")
              vim.lsp.buf.document_highlight()
            end,
          })

          -- 移动时：只有换词才清除，避免闪烁
          vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = bufnr,
            callback = function()
              local word = vim.fn.expand("<cword>")
              if last_word and word ~= last_word then
                last_word = nil
                vim.lsp.buf.clear_references()
              end
            end,
          })
        end,
      })
      -- local capabilities = require("blink.cmp").get_lsp_capabilities()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      for _, server in ipairs(lsp) do
        vim.lsp.config(server, {
          on_attach = on_attach,
          capabilities = capabilities,
        })
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
