so ~/vim/.bundles

filetype plugin indent on

set smartindent
set ts=4
set shiftwidth=4
set expandtab
set listchars=tab:>~,nbsp:_,trail:.
set scrolloff=3
set list
set number
set backspace=start,indent,eol
set t_Co=256
set hlsearch
set tags+=./tags.vendors,tags.vendors
setlocal spell spelllang=en_us
set nospell
set wildignore+=**/.git/*,**/.node_modules/*,**/.svn/*,**/vendor/*
syntax on

"Colour column
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80,120"

" Persistent Undo
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir
if has('persistent_undo')
    let myUndoDir = expand(vimDir.'/undodir')
    "Create dirs
    call system('mkdir '.vimDir)
    call system('mkdir '.myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" Go back to last position of a file when opening
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

filetype plugin indent on
au BufRead,BufNewFile *.php setl ft=php
au BufRead,BufNewFile *.less setl ft=css
au BufRead,BufNewFile *.twig setl ft=html
au BufRead,BufNewFile *.hbs setl ft=html
au BufNewFile * silent! 0r ~/.vim/skeleton/template.%:e
" augroup RemoveWhitespace
"     autocmd!
"     autocmd BufWritePre *.php :%s/\s\+$//e
" augroup END

"syntax enable
set background=dark
colorscheme solarized
hi Normal ctermbg=none

au FileType php set omnifunc=phpcomplete#CompletePHP

" Linters and hinters
let JSHintUpdateWriteOnly=1

if version > 730
    let &colorcolumn="120"
    highlight ColorColumn ctermbg=235
endif

"JSHint highlight colour dark red
hi SpellBad cterm=bold ctermfg=white ctermbg=52

let mapleader = ","

" Copy/Paste from X Clipboard
nnoremap <Leader>p :.-1r !xsel -b<CR>
vnoremap <silent> <Leader>y :w !xsel -b<CR><CR>

" Beautif JS
au BufEnter,BufNew *.js nnoremap <Leader>b :call BeautifyJs()<CR>
function! BeautifyJs()
    execute ":1,$d|0r ! uglifyjs -b %"
endfunction
au BufEnter,BufNew *.js nnoremap <Leader>u :call UglifyJs()<CR>
function! UglifyJs()
    execute ":1,$d|0r ! uglifyjs %"
endfunction

" PHP Doc Blocks
let g:pdv_template_dir = $HOME ."/.vim/pdvTemplates"
nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

" Duplicate line
map <S-D> Yp

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
"let g:airline_theme="powerlineish"
set laststatus=2

" Syntastic
let g:syntastic_php_phpcs_args="--standard=EnableIT --report=csv"
let g:syntastic_php_phpcs_exe="/home/stuart/.composer/vendor/bin/phpcs"
let g:syntastic_php_checkers=['php', 'phpmd', 'phpcs']
let g:syntastic_javascript_jshint_args = "--config /home/stuart/.jshintrc"
let g:syntastic_php_phpmd_post_args = "/home/stuart/codingstandards/EnableIT/phpmd.xml"
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_style_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_warning_symbol = "⚠"

" Sort use statements
vmap <Leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>

" Schlepp
vmap <unique> <up>    <Plug>SchleppUp
vmap <unique> <down>  <Plug>SchleppDown
vmap <unique> <left>  <Plug>SchleppLeft
vmap <unique> <right> <Plug>SchleppRight
vmap <unique> D <Plug>SchleppDup
let g:Schlepp#dupTrimWS = 1

" nerdTREE
"set autochdir
"let NERDTreeChDirMode=2
nnoremap <C-k><C-b> :NERDTreeToggle .<CR>

" Reselect visual block after in/outdent
vnoremap < <gv
vnoremap > >gv

vnoremap <Leader>a :s/\([A-Z-a-z0-9_]\+\)/'\1',<CR>o);<ESC>`<O = array(<ESC>:noh<CR>0i$

" Easy split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Improve up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

" Map Utlisnip to behave more like sublime/textmate

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<numpad-enter>"
let g:UltiSnipsSnippetDirectories=["/home/stuart/.vim/UltiSnips", "/home/stuart/.vim/bundle/vim-snippets/UltiSnips"]
let g:snips_author="Stuart Fyfe <stuart@enableit.org.uk>"

" Toggle line numbers
nnoremap <Leader>l :set nu!<CR>

" Taglist
" set the names of flags
let tlist_php_settings = 'php;c:class;f:function;d:constant'
" close all folds except for current file
let Tlist_File_Fold_Auto_Close = 1
" make tlist pane active when opened
let Tlist_GainFocus_On_ToggleOpen = 1
" width of window
let Tlist_WinWidth = 40
" close tlist when a selection is made
let Tlist_Close_On_Select = 1

if &term =~ '^gnome'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
    execute "set <PageUp>=\e[5;*~"
    execute "set <PageDown>=\e[6;*~"
    execute "set <F1>=\eOP"
    execute "set <F2>=\eOQ"
    execute "set <F3>=\eOR"
    execute "set <F4>=\eOS"
    execute "set <xF1>=\eO1;*P"
    execute "set <xF2>=\eO1;*Q"
    execute "set <xF3>=\eO1;*R"
    execute "set <xF4>=\eO1;*S"
    execute "set <F5>=\e[15;*~"
    execute "set <F6>=\e[17;*~"
    execute "set <F7>=\e[18;*~"
    execute "set <F8>=\e[19;*~"
    execute "set <F9>=\e[20;*~"
    execute "set <F10>=\e[21;*~"
    execute "set <F11>=\e[23;*~"
    execute "set <F12>=\e[24;*~"
endif

map <PageUP> :bn<CR>
map <PageDown> :bp<CR>

" Xdebug
map <F10> :python debugger_globals()<cr>
map <F11> :python debugger_context()<cr>
map <F12> :python debugger_property()<cr>
let g:debuggerMaxDepth = 5

let g:ctrlp_map = '<Leader>t'
let g:ctrlp_max_depth = 40
let g:ctrlp_max_files=0
