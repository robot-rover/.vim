" Trigger Easymotion with single <Leader>
map <Leader>f <Plug>(easymotion-bd-f)
map <Leader>s <Plug>(easymotion-bd-f2)
nmap <Leader>F <Plug>(easymotion-overwin-f)
nmap <Leader>S <Plug>(easymotion-overwin-f2)

map <Leader>w <Plug>(easymotion-w)
map <Leader>W <Plug>(easymotion-b)

map <Leader>n <Plug>(easymotion-j)
map <Leader>e <Plug>(easymotion-k)

nnoremap <C-l> <cmd>lua require('fzf-lua').files()<CR>
nnoremap <Leader><Leader> <cmd>lua require('fzf-lua').lines()<CR>

"Leave Terminal with ESC
tnoremap <Esc> <C-\><C-n>

" Navigate in Terminal Mode
tnoremap <C-h> <Left>
tnoremap <C-n> <Down>
tnoremap <C-e> <Up>
tnoremap <TAB> <Right>

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

"Move between Folds
nnoremap zn zj
nnoremap ze zk

" Navigate Menus
inoremap <C-k> <C-n>
inoremap <C-_> <C-p>
inoremap <a-t> <c-x><c-o>
