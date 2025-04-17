local opts = { noremap = true, silent = true }
--local map = vim.api.nvim_set_keymap
--
local function map(mode, lhs, rhs, opts)
    if type(mode) == 'table' then
        for i = 1, #mode do
            map(mode[i], lhs, rhs, opts)
        end
        return
    end
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

map({"n", "v", "i"}, "<A-v>", ":vsp<CR>", opt)
map({"n", "v", "i"}, "<A-m>", ":sp<CR>", opt)
map({"n", "v", "i"}, "<A-c>", "<C-w>c", opt)
map({"n", "v", "i"}, "<A-o>", "<C-w>o", opt)

map({"n", "v", "i"}, "<A-h>", "<C-w>h", opt)
map({"n", "v", "i"}, "<A-j>", "<C-w>j", opt)
map({"n", "v", "i"}, "<A-k>", "<C-w>k", opt)
map({"n", "v", "i"}, "<A-l>", "<C-w>l", opt)
map("n", "q", ":q<CR>", opt)
map("v", "p", '"_dP', opt)

map({"n", "v"}, "p", "\"0p", opt)

map("n", "<leader>m", ":sp | terminal<CR>", opt)
map("n", "<leader>v", ":vsp | terminal<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<leader>h", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<leader>j", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<leader>k", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<leader>l", [[ <C-\><C-N><C-w>l ]], opt)
--nvim-tree
map({"n", "v", "i"}, "<A-'>", ":NvimTreeFindFileToggle<CR>", opt)
map({"n", "v", "i"}, "<A-;>", ":NvimTreeFindFile<CR>", opt)
--bufferline
-- map('n', '<leader>[', '<Cmd>BufferLineCyclePrev<CR>', opt)
-- map('n', '<leader>]', '<Cmd>BufferLineCycleNext<CR>', opt)

--goto-preview
map("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})

vim.keymap.set("n", "<leader>fo", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, bufopts)

