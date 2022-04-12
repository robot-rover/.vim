let g:EasyMotion_do_mapping = 0 " Disable defaults
let g:EasyMotion_smartcase = 1

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
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
