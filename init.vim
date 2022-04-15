let g:EasyMotion_do_mapping = 0 " Disable defaults
let g:EasyMotion_smartcase = 1

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

" :PlugInstall installs plugins
call plug#begin()
Plug 'tpope/vim-sensible'

" Smooth Scroll
Plug 'karb94/neoscroll.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Fuzzy File Search
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
" optional for icon support
Plug 'kyazdani42/nvim-web-devicons'

" Rust https://github.com/simrat39/rust-tools.nvim
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'

" Debugging
" Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'
call plug#end()

:lua require('rust-tools').setup({})
" :lua require('neoscroll').setup()

" Folding w/ Treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
autocmd BufWinEnter * silent! :%foldopen!

source ~/.vimrc

" Trigger Easymotion with single <Leader>
map <Leader>f <Plug>(easymotion-f)
map <Leader>s <Plug>(easymotion-f2)
nmap <Leader>F <Plug>(easymotion-overwin-f)
nmap <Leader>S <Plug>(easymotion-overwin-f2)

map <Leader>w <Plug>(easymotion-w)
map <Leader>W <Plug>(easymotion-b)

map <Leader>n <Plug>(easymotion-j)
map <Leader>e <Plug>(easymotion-k)

"Leave Terminal with ESC
tnoremap <Esc> <C-\><C-n>

" Navigate in Terminal Mode
tnoremap <C-h> <Left>
tnoremap <C-n> <Down>
tnoremap <C-e> <Up>
tnoremap <C-i> <Right>

" Alt to move windows in any mode
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-n> <C-\><C-N><C-w>j
tnoremap <A-e> <C-\><C-N><C-w>k
tnoremap <A-i> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-n> <C-\><C-N><C-w>j
inoremap <A-e> <C-\><C-N><C-w>k
inoremap <A-i> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-n> <C-w>j
nnoremap <A-e> <C-w>k
nnoremap <A-i> <C-w>l

