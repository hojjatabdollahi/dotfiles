set shell=/bin/bash
" stuff from vim
" I moved this here to make sure that all the plugins use this leader
let mapleader = " " 

call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'honza/vim-snippets'
Plug '9mm/vim-closer'
Plug 'tpope/vim-commentary'
Plug 'sainnhe/edge'
Plug 'tweekmonster/startuptime.vim'
Plug 'mizlan/termbufm'
Plug 'mhinz/vim-signify'
Plug 'SirVer/ultisnips'

Plug 'rust-lang/rust.vim'
"Plug 'vim-syntastic/syntastic'
"Plug 'preservim/tagbar'
Plug 'airblade/vim-gitgutter'
"Plug 'preservim/nerdcommenter'
Plug 'racer-rust/vim-racer'
Plug 'AndrewRadev/sideways.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'easymotion/vim-easymotion'
Plug 'mbbill/undotree'
Plug 'tpope/vim-sensible'
Plug 'joshdick/onedark.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
"Plug 'cespare/vim-toml'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'rhysd/vim-clang-format'
"Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

Plug 'justinmk/vim-sneak'
Plug 'voldikss/vim-floaterm'
"Plug 'jackguo380/vim-lsp-cxx-highlight'
call plug#end()

let g:sneak#label = 1

" I moved this here to make sure that all the plugins use this leader
let mapleader = " " 

" undotree
nnoremap <F7> :UndotreeToggle<cr>

nnoremap <Leader>F :<C-u>ClangFormat<CR>

syntax enable
filetype plugin on
filetype plugin indent on

colorscheme onedark
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
"  set statusline+=%*

"let g:syntastic_cpp_checkers = ['cpplint']
"let g:syntastic_c_checkers = ['cpplint']
"let g:syntastic_cpp_cpplint_exec = 'cpplint'
" The following two lines are optional. Configure it to your liking!
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0


"nmap <F8> :TagbarToggle<CR>


"map <F9> :CHADopen<CR>
"autocmd VimEnter * CHADopen --nofocus
"autocmd VimEnter * wincmd p
" close chad tree if the last file is closed
"

"autocmd bufenter * if (winnr("$") == 1 && &ft=="CHADtree") | q | endif

"let g:chadtree_settings = {"view.width": 25,  "theme.icon_colour_set": "github" }




" git gutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '-'


" Nerd commenter
" For some reason vim thinks <C-/> is <C-_>
"nmap <C-_> <Plug>NERDCommenterToggle
"vmap <C-_> <Plug>NERDCommenterToggle<CR>gv




" Rust plugin
let g:rustfmt_autosave = 1

" Racer
let g:racer_cmd = "/home/hojjat/.cargo/bin/racer"
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

set ts=2 sts=2 sw=2 et list lcs=tab:┆·,trail:·,precedes:,extends:
set hid nowrap spr sb ic scs nu rnu tgc nosmd swb=useopen scl=yes nosc noru icm=split
set udir=~/.local/share/nvim/undodir udf
set cot=menuone,noinsert,noselect shm+=c
set bg=dark
let g:edge_style = 'neon'
colo edge

let $V=stdpath('config')
so $V/xstl.vim
so $V/aesth.vim

let g:diagnostic_virtual_text_prefix = ''
let g:diagnostic_enable_virtual_text = 1

:lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  require('completion').on_attach()
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF




" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
"
"map <c-p> to manually trigger completion
" imap <silent> <c-p> <Plug>(completion_trigger)

" imap <tab> <Plug>(completion_smart_tab)
" imap <s-tab> <Plug>(completion_smart_s_tab)

" let g:completion_confirm_key = "\<C-y>"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_smart_case = 1
let g:completion_trigger_on_delete = 1

let g:UltiSnipsExpandTrigger = '<f5>'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
augroup CompletionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.']
    autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::']
augroup end

imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)


" :lua << EOF
"   local nvim_lsp = require('lspconfig')
"   local on_attach = function(_, bufnr)
"     -- require('diagnostic').on_attach()
"     require('completion').on_attach()
"     local opts = { noremap=true, silent=true }
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
"     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
"   end
"   local servers = {'jsonls', 'vimls', 'clangd', 'rust_analyzer', 'cssls', 'html', 'jdtls', 'sumneko_lua'}
"   for _, lsp in ipairs(servers) do
"     nvim_lsp[lsp].setup {
"       on_attach = on_attach,
"     }
"   end
" EOF

" :lua << EOF
"     vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
"   vim.lsp.diagnostic.on_publish_diagnostics, {
"     -- Enable underline, use default values
"     underline = true,
"     -- Enable virtual text, override spacing to 4
"     virtual_text = {
"       spacing = 4,
"       prefix = '~',
"     },
"     -- Use a function to dynamically turn signs off
"     -- and on, using buffer local variables
"     signs = function(bufnr, client_id)
"       local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
"       -- No buffer local variable set, so just enable by default
"       if not ok then
"         return true
"       end

"       return result
"     end,
"     -- Disable a feature
"     update_in_insert = false,
"   }
" )
" EOF

command! -buffer -nargs=0 LspShowLineDiagnostics lua require'jumpLoc'.openLineDiagnostics()
nnoremap <buffer><silent> <C-h> <cmd>LspShowLineDiagnostics<CR>
command! Format execute 'lua vim.lsp.buf.formatting()'

:lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      disable = { },
    },
  }
EOF

let g:markdown_fenced_languages = ['sh', 'vim']

let mapleader = " "
nn <silent> <leader>n :noh<CR>
tno <silent> <Esc> <C-\><C-n>

nn <silent> <leader>b :call TermBufMExecCodeScript(&filetype, 'build')<CR>
nn <silent> <leader>r :call TermBufMExecCodeScript(&filetype, 'run')<CR>
nn <silent> <leader>f :call TermBufMExec('pbpaste > input')<CR>
nn <silent> <leader><space> :call TermBufMToggle()<CR>

let g:termbufm_code_scripts = {
      \ 'python': { 'build': [''],                                     'run': ['cat input | python %s', '%'] },
      \ 'cpp':    { 'build': ['g++ -std=c++11 %s', '%'],               'run': ['cat input | ./a.out'] },
      \ 'java':   { 'build': ['javac %s', '%'],                        'run': ['cat input | java %s', '%:r'] },
      \ 'c':      { 'build': ['gcc %s', '%'],                          'run': ['cat input | ./a.out'] },
      \ }

nn <silent> <leader>j :NextDiagnosticCycle<CR>
nn <silent> <leader>k :PrevDiagnosticCycle<CR>

"enable mouse support
set mouse=a


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

" fzf
nnoremap <c-p> :Files<CR>








"" TextEdit might fail if hidden is not set.
"set hidden

"" Some servers have issues with backup files, see #649.
"set nobackup
"set nowritebackup

"" Give more space for displaying messages.
"set cmdheight=2

"" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"" delays and poor user experience.
"set updatetime=300

"" Don't pass messages to |ins-completion-menu|.
"set shortmess+=c

"" Always show the signcolumn, otherwise it would shift the text each time
"" diagnostics appear/become resolved.
"if has("patch-8.1.1564")
  "" Recently vim can merge signcolumn and number column into one
  "set signcolumn=number
"else
  "set signcolumn=yes
"endif

"" Use tab for trigger completion with characters ahead and navigate.
"" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> to trigger completion.
"if has('nvim')
  "inoremap <silent><expr> <c-space> coc#refresh()
"else
  "inoremap <silent><expr> <c-@> coc#refresh()
"endif

"" Make <CR> auto-select the first completion item and notify coc.nvim to
"" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              "\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"" Use `[g` and `]g` to navigate diagnostics
"" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>

"function! s:show_documentation()
  "if (index(['vim','help'], &filetype) >= 0)
    "execute 'h '.expand('<cword>')
  "elseif (coc#rpc#ready())
    "call CocActionAsync('doHover')
  "else
    "execute '!' . &keywordprg . " " . expand('<cword>')
  "endif
"endfunction

"" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

"" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)

"" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

"augroup mygroup
  "autocmd!
  "" Setup formatexpr specified filetype(s).
  "autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  "" Update signature help on jump placeholder.
  "autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end

"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

"" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)

"" Map function and class text objects
"" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"xmap if <Plug>(coc-funcobj-i)
"omap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap af <Plug>(coc-funcobj-a)
"xmap ic <Plug>(coc-classobj-i)
"omap ic <Plug>(coc-classobj-i)
"xmap ac <Plug>(coc-classobj-a)
"omap ac <Plug>(coc-classobj-a)

"" Remap <C-f> and <C-b> for scroll float windows/popups.
"" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
"nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

"" NeoVim-only mapping for visual mode scroll
"" Useful on signatureHelp after jump placeholder of snippet expansion
"if has('nvim')
  "vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  "vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
"endif

"" Use CTRL-S for selections ranges.
"" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

"" Add `:Format` command to format current buffer.
"command! -nargs=0 Format :call CocAction('format')

"" Add `:Fold` command to fold current buffer.
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"" Add `:OR` command for organize imports of the current buffer.
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Add (Neo)Vim's native statusline support.
"" NOTE: Please see `:h coc-status` for integrations with external plugins that
"" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Mappings for CoCList
"" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


:set nofoldenable 
:set foldmethod=syntax














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

nmap <leader>q :q<CR>

nnoremap <F5> :!cargo run<CR>

" <Leader>f{char} to move to {char}
"map  <Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
"nmap s <Plug>(easymotion-overwin-f2)

" Move to line
"map <Leader>L <Plug>(easymotion-bd-jk)
"nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
"map  <Leader>w <Plug>(easymotion-bd-w)
"nmap <Leader>w <Plug>(easymotion-overwin-w)

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Ctrl+j and Ctrl+k as Esc
" Ctrl-j is a little awkward unfortunately:
" https://github.com/neovim/neovim/issues/5916
" So we also map Ctrl+k
nnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
snoremap <C-j> <Esc>
xnoremap <C-j> <Esc>
cnoremap <C-j> <C-c>
onoremap <C-j> <Esc>
lnoremap <C-j> <Esc>
tnoremap <C-j> <Esc>

nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <C-c>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Suspend with Ctrl+f
"inoremap <C-f> :sus<cr>
"vnoremap <C-f> :sus<cr>
"nnoremap <C-f> :sus<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Neat X clipboard integration
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>
set signcolumn=yes



" terminal
set splitbelow
"set termwinsize=10x0
"nnoremap <C-x> :split term://zsh<cr>
"tnoremap <Esc> <C-\><C-n>
let g:floaterm_keymap_new = '<leader>ft'
let g:floaterm_keymap_toggle = '<leader>t'
let g:floaterm_shell = 'zsh'


" Change the shape of the cursor in Alacritty
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[0 q"

"set updatetime=300
"au CursorHold * sil call CocActionAsync('highlight')
"au CursorHoldI * sil call CocActionAsync('showSignatureHelp')

" :set expandtab
:set tabstop=4




"function! s:explorer_cur_dir()
  "let node_info = CocAction('runCommand', 'explorer.getNodeInfo', 0)
  "return fnamemodify(node_info['fullpath'], ':h')
"endfunction

"function! s:exec_cur_dir(cmd)
  "let dir = s:explorer_cur_dir()
  "execute 'cd ' . dir
  "execute a:cmd
"endfunction

"function! s:init_explorer()
  "set winblend=10

  "" Integration with other plugins

  "" CocList
  "nmap <buffer> <Leader>fg :call <SID>exec_cur_dir('CocList -I grep')<CR>
  "nmap <buffer> <Leader>fG :call <SID>exec_cur_dir('CocList -I grep -regex')<CR>
  "nmap <buffer> <C-p> :call <SID>exec_cur_dir('CocList files')<CR>

  "" vim-floaterm
  "nmap <buffer> <Leader>ft :call <SID>exec_cur_dir('FloatermNew --wintype=floating')<CR>
"endfunction

"function! s:enter_explorer()
  "if &filetype == 'coc-explorer'
    "" statusline
    "setl statusline=coc-explorer
  "endif
"endfunction

"augroup CocExplorerCustom
  "autocmd!
  "autocmd BufEnter * call <SID>enter_explorer()
  "autocmd FileType coc-explorer call <SID>init_explorer()
"augroup END


":nmap <F9> :CocCommand explorer<CR>
"autocmd VimEnter * CocCommand explorer --no-focus
"autocmd VimEnter * wincmd p
"autocmd bufenter * if (winnr("$") == 1 && &ft=="coc-explorer") | q | endif


let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END


:nmap <F9> :Vexplorer<CR>
autocmd bufenter * if (winnr("$") == 1 && &ft=="netrw") | q | endif
