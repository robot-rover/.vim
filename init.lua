-- In case of errors, do this first
vim.cmd 'source ~/.vimrc'
vim.cmd 'source ~/.vim/bindings.vim'

-- Disable EasyMotion Defaults
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_do_smartcase = 1

-- https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'dracula/vim'

-- Smooth Scroll
Plug 'karb94/neoscroll.nvim'

-- Treesitter
-- TODO: Add incremental search bindings
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

-- Fuzzy File Search
Plug('ibhagwan/fzf-lua', {['branch'] = 'main'})
Plug 'kyazdani42/nvim-web-devicons'

-- Rust https://github.com/simrat39/rust-tools.nvim
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'

-- Git Integration
Plug 'lewis6991/gitsigns.nvim'
vim.call('plug#end')

require('rust-tools').setup({})
require('neoscroll').setup({hide_cursor = false})
require('gitsigns').setup()
require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "rust", "bash", "cmake", "cpp", "go",
  "java", "json", "latex", "make", "python", "toml", "verilog", "vim", "yaml"},
})

-- neoscroll keybindings

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<C-e>'] = {'scroll', {'-vim.wo.scroll', 'true', '150'}}
t['<C-n>'] = {'scroll', { 'vim.wo.scroll', 'true', '150'}}
t['zt']    = {'zt', {'150'}}
t['zz']    = {'zz', {'150'}}
t['zb']    = {'zb', {'150'}}
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

