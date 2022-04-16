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
Plug 'simrat39/rust-tools.nvim'

-- Git Integration
Plug 'lewis6991/gitsigns.nvim'
vim.call('plug#end')

require('impatient')

require('rust-tools').setup({})
require('neoscroll').setup({hide_cursor = false, easing_function = "sine"})
require('gitsigns').setup()
require('nvim-treesitter.configs').setup({
-- TODO: Add incremental search bindings
  ensure_installed = { "c", "lua", "rust", "bash", "cmake", "cpp", "go",
  "java", "json", "latex", "make", "python", "toml", "verilog", "vim", "yaml"},
  highlight = { enable = true },
  indent = { enable = true },
})

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

