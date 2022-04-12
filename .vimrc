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

"Leave Terminal with ESC
:tnoremap <Esc> <C-\><C-n>

" Alt to move windows in any mode
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-n> <C-\><C-N><C-w>j
:tnoremap <A-e> <C-\><C-N><C-w>k
:tnoremap <A-i> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-n> <C-\><C-N><C-w>j
:inoremap <A-e> <C-\><C-N><C-w>k
:inoremap <A-i> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-n> <C-w>j
:nnoremap <A-e> <C-w>k
:nnoremap <A-i> <C-w>l
