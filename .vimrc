syntax enable

" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

filetype indent on
filetype plugin on


" visuals
set number
set showcmd
set cursorline
hi CursorLine   cterm=NONE ctermbg=0 ctermfg=NONE

" autocomplete
set wildmenu


"set lazyredraw "stop screen redrawing during macros

"set showmatch "highlight matching brackets

" searching
set incsearch
set hlsearch
nnoremap <leader><space> :nohlsearch<CR> "turn off search highlight

" folding
set foldenable
set foldlevelstart=10

nnoremap <space> za "open close folds
set foldmethod=indent

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" highlight last inserted text
nnoremap gV `[v`]

let mapleader=","  "leader is comma

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
"let g:gundo_preview_bottom = 1
let g:gundo_return_on_revert = 0

" save session
nnoremap <leader>s :mksession<CR>

" open ack.vim
nnoremap <leader>a :Ack<space>
let g:ackprg = 'ag --vimgrep --smart-case'  

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" move backup
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" syntax checker
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" close tree if only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" move windows with ctrl
nnoremap <C-J> <C-W>j<C-W>_
nnoremap <C-K> <C-W>k<C-W>_
nnoremap <C-H> <C-W>h<C-W>_
nnoremap <C-L> <C-W>l<C-W>_

execute pathogen#infect()
