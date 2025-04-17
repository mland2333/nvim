return {
  {
    'stevearc/conform.nvim',
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "williamboman/mason.nvim" },
    },
    lazy = true,
    cmd = "ConformInfo",
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false,           -- not recommended to change
        quiet = false,           -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },


      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
    --   keys = {
    --   {
    --     "<leader>fo",
    --     function()
    --       require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
    --     end,
    --     mode = { "n", "v" },
    --     desc = "Format Injected Langs",
    --   },
    -- },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },

    config = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end
  }
}
