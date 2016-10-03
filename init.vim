call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-fugitive'
Plug 'hail2u/vim-css3-syntax'
Plug 'bling/vim-airline'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'othree/html5.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'hdima/python-syntax'
"Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'hynek/vim-python-pep8-indent'
"Plug 'Valloric/YouCompleteMe'
Plug 'kchmck/vim-coffee-script'
Plug 'mustache/vim-mustache-handlebars'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'digitaltoad/vim-pug'
Plug 'derekwyatt/vim-scala'
Plug 'xolox/vim-misc'
"Plug 'xolox/vim-easytags'
"Plug 'scrooloose/syntastic' , { 'for': ['typescript'] }
Plug 'kopischke/vim-stay'
Plug 'dart-lang/dart-vim-plugin'
Plug 'leafgarland/typescript-vim'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'powerman/vim-plugin-AnsiEsc'
"Plug 'vim-scripts/c.vim', { 'for': ['cpp', 'c'] }
""Plug 'bobogei81123/Vim-Chinese-Forward'
"Plug 'zz/ver'
Plug 'benekastah/neomake'
"Plug 'zchee/deoplete-clang'
"Plug 'Rip-Rip/clang_complete'
Plug 'tpope/vim-unimpaired'
Plug 'cakebaker/scss-syntax.vim'
Plug 'posva/vim-vue'

call plug#end()

colorscheme pika
syntax on

highlight Normal ctermbg=None

set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set number relativenumber
set whichwrap+=<,>,[,]
set timeoutlen=300
set ttimeoutlen=200
set scrolloff=4
set hidden
set laststatus=2
set path=$PWD/**
set nostartofline

filetype indent plugin on
autocmd BufReadPost quickfix AnsiEsc

au BufNewFile *.cpp 0r ~/Templates/skeleton.cpp
au BufNewFile *.cc 0r ~/Templates/skeleton.cc | :1,$-7 fo
au FileType c,cc,cpp setl makeprg=g++\ -fconcepts\ -fdiagnostics-color=auto\ -Wall\
			\ -Wshadow\ -Wextra\ -O2\ -DDEBUG\ -DOFFLINE\ -o\ %<\ %

au FileType haskell setl makeprg=ghc\ -o\ %<\ %


au FileType tex setl makeprg=xelatex\ -interaction=nonstopmode\ -shell-escape\ %
au BufNewFile *.tex 0r ~/Templates/skeleton.tex
au filetype tex setl ts=2 sw=2 sts=2

au BufWritePost *.tex silent call Compile_LaTeX()

func! Compile_LaTeX()
    exec "!xelatex -shell-escape -interaction=nonstopmode % > /dev/null 2>&1  &"
endfunc

let g:easytags_events = ['BufWritePost']

"au BufEnter * silent! lcd %:p:h

"autocmd BufNewFile,BufRead *.vue set filetype=html
au filetype html,yaml,jade,pug setl ts=2 sw=2 sts=2
"au filetype css,sass,scss setl ts=2 sw=2 sts=2
"au filetype python setl ts=2 sw=2 sts=2

"au filetype coffeescript,coffee setl ts=2 sw=2 sts=2
"au BufNewFile,BufRead *.coffee setl ts=2 sw=2 sts=2

au FileType java setl makeprg=javac\ %

au BufNewFile,BufRead *.gv setl makeprg=dot\ -Tpng\ -o\ %<.png\ %

au BufNewFile,BufRead *.css set filetype=scss

au FileType java set makeprg=javac\ %

let mapleader=' '

"pathogen
"exec pathogen#infect()

"let g:tex_fold_enabled = 1
let g:tex_nine_config = {
    \'compiler': 'xelatex',
    \'synctex': 1,
    \'leader': ';'
	\}
let g:tex_nine_templates = 0

let g:tex_flavor = "latex"

let g:tex_conceal = ""
let g:indentLine_char = "│"

"powerline Source Code Pro font
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:indentLine_char = '│'
let python_highlight_all = 1

" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_debug = 1
let g:deoplete#enable_profile = 1
let g:deoplete#sources = { "_" : [] }
set completeopt-=preview

function! QFSwitch()
    redir => ls_output
    execute ':silent! ls'
    redir END

    let exists = match(ls_output, "[Quickfix List")
    if exists == -1
        execute ':copen'
    else
        execute ':cclose'
    endif
endfunction

nnoremap <F7> :wa<CR>:make!<CR>
nnoremap <F8> :call QFSwitch()<CR>
"nnoremap <S-F8> :cclose<CR>
nnoremap <F9> :call Exc()<CR>
nnoremap <F33> :call Exc_with_fin()<CR>

map j gj
map k gk
map 0 ^


let NERDTreeShowHidden=1
noremap : ,
noremap , :
nnoremap <leader>n :NERDTreeToggle<CR>

nnoremap <leader>t :TagbarToggle<CR>

"fugitive
nnoremap <leader>gs :Gstatus <CR>
nnoremap <leader>gc :Gcommit <CR>

nnoremap <F5> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


"Buffer 
nnoremap <leader>l :bn<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader>q :bd<CR>
tnoremap <C-[> <C-\><C-n>
tnoremap <C-a>l <C-\><C-n>:bn<CR>
tnoremap <C-a>h <C-\><C-n>:bp<CR>
tnoremap <C-a>q <C-\><C-n>:bd<CR>
autocmd TermOpen * nmap <buffer> <C-a> <space>
autocmd TermOpen * nnoremap <buffer> <CR> A<CR>


nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>
map <leader>j :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>



func! Exc()
	let curr_file = expand('%:e')
	if curr_file == "c" || curr_file == "cpp" || curr_file == "hs" || curr_file == "cc"
		term ./%<
	elseif curr_file == "py"
		term python3 %
	elseif curr_file == "tex"
		exec "silent ! zathura %<.pdf > /dev/null 2>&1 &"
	elseif curr_file == "ng"
		exec "!ngspice ./%"
	elseif curr_file == "m"
		exec "!octave ./%"
    elseif curr_file == "html"
        exec "silent !firefox ./% > /dev/null 2>&1 &"
    elseif curr_file == "gv"
        exec "silent ! eog ./%<.png > /dev/null 2>&1 &"
    elseif curr_file == "vim"
        exec ":source %"
	endif
endfunc

func! Exc_with_fin()
	term ./%< < %<.in
endfunc

let g:dictionary_file = "/home/meteor/.vim/plugged/Vim-Chinese-Forward/boshami.dict"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 2
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler_options = ' -std=c++14 -Wall -Wshadow -fsyntax-only'
let g:syntastic_python_python_exec = '/usr/bin/python3.5'
let g:syntastic_python_checkers = ['pyflakes']

let g:syntastic_typescript_tsc_args = '--target ES6'

let g:ycm_global_ycm_extra_conf = '/home/meteor/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_error_symbol = '⚠ '
let g:ycm_warning_symbol = '⚠ '
"let g:ycm_warning_symbol = '>> '

if has("gui_running")
    set guioptions-=T "remove toolbar
    set guioptions-=m "remove menubar
    set guioptions-=r "remove scrollbar
endif
set guifont=monospace\ 18

set viewoptions=cursor,folds,slash,unix
augroup stay_no_lcd
    autocmd!
    autocmd User BufStaySavePre  if haslocaldir() | let w:lcd = getcwd() | cd - | cd - | endif
    autocmd User BufStaySavePost if exists('w:lcd') | execute 'lcd' fnameescape(w:lcd) | unlet w:lcd | endif
augroup END

highlight SignError ctermfg=160 cterm=bold ctermbg=234
highlight SignWarning ctermfg=166 ctermbg=234
let g:neomake_error_sign = {'text': '✖', 'texthl': 'SignError'}
let g:neomake_warning_sign = {'text': '⚠', 'texthl': 'SignWarning'}
" Always show sign column
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

let g:neomake_cpp_gcc_maker = {
    \ 'args': ['--std=c++11', '-fsyntax-only', '-Wall', '-Wextra', '-Wunused', '-DOFFLINE'],
    \ 'errorformat':
        \ '%-G%f:%s:,' .
        \ '%-G%f:%l: %#error: %#(Each undeclared identifier is reported only%.%#,' .
        \ '%-G%f:%l: %#error: %#for each function it appears%.%#,' .
        \ '%-GIn file included%.%#,' .
        \ '%-G %#from %f:%l\,,' .
        \ '%f:%l:%c: %trror: %m,' .
        \ '%f:%l:%c: %tarning: %m,' .
        \ '%f:%l:%c: %m,' .
        \ '%f:%l: %trror: %m,' .
        \ '%f:%l: %tarning: %m,'.
        \ '%f:%l: %m',
    \ }
let g:neomake_cpp_enabled_makers = ['gcc']
au! BufWritePost * Neomake

function! s:addCCKeyword()
    execute "syntax keyword Statement loop"
    execute "syntax keyword Type au"
    execute "syntax keyword Type vec"
    execute "syntax keyword Type set"
    execute "syntax keyword Type map"
    execute "syntax keyword Type pair"
    execute "syntax keyword Type array"
    execute "syntax keyword Operator dump"
endfunction
autocmd BufNewFile,BufReadPost *.cc :call s:addCCKeyword()

"so ~/.vim/ftplugin/veriexp.vim
