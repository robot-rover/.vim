filetype plugin indent on
set mouse=a
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Colemak Navigation
noremap n j
noremap e k
noremap i l

" Allow ciw and friends in operator pending
ounmap n
ounmap e
ounmap i

" Navigate in Normal Mode
inoremap <C-h> <Left>
inoremap <C-n> <Down>
inoremap <C-e> <Up>
inoremap <C-i> <Right>

" Colemak Search
noremap k n
noremap <S-k> <S-n>

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

