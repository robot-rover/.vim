-- In case of errors, do this first
vim.cmd 'source ~/.vimrc'
-- vim.cmd 'source ~/.vim/bindings.vim'
require('bindings')

vim.loader.enable()

-- Lazy Setup
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
require("lazy").setup("plugin-spec")

if not vim.g.vscode then
  -- require('lspconfig').pylsp.setup({})

  -- require('rust-tools').setup({})
  -- require('neoscroll').setup { hide_cursor = false, easing_function = "sine" }
  -- require('gitsigns').setup { debug_mode=true }
  -- require('nvim-treesitter.configs').setup {
  -- -- TODO: Add incremental search bindings
  --   ensure_installed = { "c", "lua", "rust", "bash", "cmake", "cpp", "go",
  --   "java", "json", "make", "python", "toml", "verilog", "yaml"},
  --   highlight = { enable = true },
  --   --indent = { enable = true },
  -- }

  -- neoscroll keybindings

  -- local t = {}
  -- -- Syntax: t[keys] = {function, {function arguments}}
  -- t['<C-e>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
  -- t['<C-n>'] = {'scroll', { 'vim.wo.scroll', 'true', '250'}}
  -- t['zt']    = {'zt', {'250'}}
  -- t['zz']    = {'zz', {'250'}}
  -- t['zb']    = {'zb', {'250'}}
  -- require('neoscroll.config').set_mappings(t)

  -- Folding w/ Treesitter
  -- TODO: Do this with lua?
  -- vim.cmd([[
  -- set foldmethod=expr
  -- set foldexpr=nvim_treesitter#foldexpr()
  -- autocmd BufWinEnter * silent! :%foldopen!
  -- ]])

  -- lsp keybindings
  -- local opts = { noremap=true, silent=true }
  -- vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  -- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  -- local on_attach = function(client, bufnr)
  --   -- Enable completion triggered by <c-x><c-o>
  --   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  --   -- Mappings.
  --   -- See `:help vim.lsp.*` for documentation on any of the below functions
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-p>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-p>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  -- end

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
--   local servers = { 'pylsp', 'rust_analyzer' }
--   for _, lsp in pairs(servers) do
--     require('lspconfig')[lsp].setup {
--       on_attach = on_attach,
--       flags = {
--         -- This will be the default in neovim 0.7+
--         debounce_text_changes = 150,
--       }
--     }
--   end
end
