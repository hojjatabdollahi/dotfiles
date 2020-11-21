execute pathogen#infect()

" I moved this here to make sure that all the plugins use this leader
let mapleader = " " 

" undotree
nnoremap <F7> :UndotreeToggle<cr>

" vim sensible
runtime! plugin/sensible.vim

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 0
"let g:syntastic_mode_map = {'mode':'passive'}
nnoremap <F4> :SyntasticCheck<CR> 

map <F3> <ESC>:call SyntasticToggle()<CR>
let g:syntastic_is_open = 0
function! SyntasticToggle()
    if g:syntastic_is_open == 1
	lclose
	let g:syntastic_is_open = 0
    else
	Errors 
	let g:syntastic_is_open = 1
    endif
endfunction

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Nerd Tree
map <F9> :NERDTreeToggle<CR>
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
" close nerd tree if the last file is closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Nerd Tree Git plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
" git gutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '-'
" Nerd commenter
" For some reason vim thinks <C-/> is <C-_>
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" Rust plugin
let g:rustfmt_autosave = 1

" Racer
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
    autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
    autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
    autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
    autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
    autocmd FileType rust nmap <buffer> <leader>gD <Plug>(rust-doc-tab)
augroup END

" sideways
nnoremap <c-h> :SidewaysLeft<cr>
nnoremap <c-l> :SidewaysRight<cr>

" Coc
source ~/.vim/bundle/coc.nvim/vimrc

" fzf
nnoremap <c-p> :Files<CR>

"enable mouse support
set mouse=a


filetype plugin indent on
syntax on


" Fix the problem with "modifyOtherKeys" 
" This error causes random stuff to be saved when I press :w
let &t_TI = ""
let &t_TE = ""


set nobackup
set undodir=~/.vim/undodir
set undofile
set nu
set relativenumber
set smartcase
set shiftwidth=4

" This disables the annoying beep when pressing tab
set noerrorbells visualbell t_vb=
"set  colorcolumn=80
"highligh ColorColumn ctermbg=7 guibg=lightgrey

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeToggle<CR> 

nnoremap <c-j> i<cr><Esc>

""" Customize colors
func! s:my_colors_setup() abort
    " this is an example
    hi Pmenu guibg=#d7e5dc gui=NONE
    hi PmenuSel guibg=#b7c7b7 gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858
endfunc

augroup colorscheme_coc_setup | au!
    au ColorScheme * call s:my_colors_setup()
augroup END
colorscheme codedark
let g:airline_theme = 'codedark'
nmap <leader>q :q<CR>

nnoremap <F5> :!cargo run<CR>
