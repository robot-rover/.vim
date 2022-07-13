-- In case of errors, do this first
vim.cmd 'source ~/.vimrc'
vim.cmd 'source ~/.vim/bindings.vim'

require('env')

-- Disable EasyMotion Defaults
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_do_smartcase = 1

-- https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'dracula/vim'

-- Speed Plugins
Plug 'nathom/filetype.nvim'
Plug 'lewis6991/impatient.nvim'

-- Smooth Scroll
Plug 'karb94/neoscroll.nvim'

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
-- TODO: https://github.com/nvim-treesitter/nvim-treesitter-refactor

-- Fuzzy File Search
Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install'] })
Plug('ibhagwan/fzf-lua', {['branch'] = 'main'})
Plug 'kyazdani42/nvim-web-devicons'

-- Rust https://github.com/simrat39/rust-tools.nvim
Plug 'neovim/nvim-lspconfig'
-- Plug 'simrat39/rust-tools.nvim'

-- Git Integration
Plug 'lewis6991/gitsigns.nvim'
vim.call('plug#end')

require('impatient')

require('lspconfig').pylsp.setup({})

-- LSP Signs
vim.g.diagnostics_active = true
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.reset()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
  else
    vim.g.diagnostics_active = true
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      }
    )
  end
end

vim.api.nvim_set_keymap('n', '<leader>tt', ':call v:lua.toggle_diagnostics()<CR>',  {noremap = true, silent = true})

-- require('rust-tools').setup({})
require('neoscroll').setup { hide_cursor = false, easing_function = "sine" }
require('gitsigns').setup { debug_mode=true }
require('nvim-treesitter.configs').setup {
-- TODO: Add incremental search bindings
  ensure_installed = { "c", "lua", "rust", "bash", "cmake", "cpp", "go",
  "java", "json", "make", "python", "toml", "verilog", "yaml"},
  highlight = { enable = true },
  --indent = { enable = true },
}

-- neoscroll keybindings

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<C-e>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
t['<C-n>'] = {'scroll', { 'vim.wo.scroll', 'true', '250'}}
t['zt']    = {'zt', {'250'}}
t['zz']    = {'zz', {'250'}}
t['zb']    = {'zb', {'250'}}
require('neoscroll.config').set_mappings(t)

-- Folding w/ Treesitter
-- TODO: Do this with lua?
vim.cmd([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
autocmd BufWinEnter * silent! :%foldopen!
]])

-- Themeing
if vim.fn.has("termguicolors") == 1 then
 vim.opt.termguicolors = true
end
-- syntax enable
vim.cmd 'colorscheme dracula'

-- lsp keybindings
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-p>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-p>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pylsp', 'rust_analyzer' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
