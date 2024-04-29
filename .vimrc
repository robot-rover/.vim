filetype plugin indent on
set mouse=a
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set ignorecase
set smartcase

" Colemak Navigation
noremap n j
noremap e k
noremap i l

" Allow ciw and friends in operator pending
ounmap n
ounmap e
ounmap i

" Use M as i in visual mode
vnoremap M i

" Ctrl-jk Scrolling
nnoremap <C-n> <C-d>
nnoremap <C-e> <C-u>
noremap zn zj
noremap N zj
noremap E zk

" Join lines with H
noremap H J

" Navigate in Insert Mode
inoremap <C-h> <Left>
inoremap <C-n> <Down>
inoremap <C-e> <Up>
inoremap <C-i> <Right>

" Colemak Search
noremap k n
noremap gk gn
noremap <S-k> <S-n>
noremap g<S-k> g<S-n>

" Colemak Insert
noremap s i
noremap <S-s> <S-i>

" [j]ump rather than [e]nd
noremap j e
noremap <S-j> <S-e>

" l for line begin and L for line end
noremap l ^
noremap <S-l> $

" Ctrl-[ to leave insert mode
noremap <C-@> <ESC>

" == to reformat file
noremap == gg=G''

