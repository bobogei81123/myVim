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
Plug 'Shougo/neocomplete.vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'kchmck/vim-coffee-script'
Plug 'mustache/vim-mustache-handlebars'
"Plug 'vim-scripts/c.vim'
"Plug 'scrooloose/syntastic'
"Plug 'bobogei81123/Vim-Chinese-Forward'

call plug#end()

colorscheme pika
syn on

highlight Normal ctermbg=None

set et
set ts=4 sw=4 sts=4
set mouse=a
set nu rnu
set ai
set ar
set bs=indent,eol,start ww+=<,>,[,]
set ttm=100
set so=4
se hid
se ls=2
se path=$PWD/**
se nosol

filetype indent plugin on

au BufNewFile *.cpp 0r ~/Templates/skeleton.cpp
au BufNewFile *.cc 0r ~/Templates/skeleton.cc
au FileType c,cc,cpp setl makeprg=g++\ -std=c++11\ -Wall\
			\ -Wshadow\ -O2\ -o\ %<\ %

au FileType haskell setl makeprg=ghc\ -o\ %<\ %


au FileType tex setl makeprg=xelatex\ -interaction=nonstopmode\ -shell-escape\ %
au BufNewFile *.tex 0r ~/Templates/skeleton.tex
au filetype tex setl ts=2 sw=2 sts=2

au BufWritePost *.tex silent call Compile_LaTeX()

func! Compile_LaTeX()
    exec "!xelatex -shell-escape -interaction=nonstopmode % > /dev/null 2>&1  &"
endfunc

"au BufEnter * silent! lcd %:p:h

au filetype html,yaml setl ts=2 sw=2 sts=2
au filetype css,sass,scss setl ts=2 sw=2 sts=2
"au filetype python setl ts=2 sw=2 sts=2

au filetype javascript,coffeescript,coffee setl ts=2 sw=2 sts=2
"au BufNewFile,BufRead *.coffee setl ts=2 sw=2 sts=2

au FileType java setl makeprg=javac\ %

au BufNewFile,BufRead *.gv setl makeprg=dot\ -Tpng\ -o\ %<.png\ %


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
let g:neocomplete#enable_at_startup = 1
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
nnoremap <C-F9> :call Exc_with_fin()<CR>

map j gj
map k gk
map 0 ^


let NERDTreeShowHidden=1
nnoremap <leader>n :NERDTreeToggle<CR>

nnoremap <leader>t :TagbarToggle<CR>

"fugitive
nnoremap <leader>gs :Gstatus <CR>
nnoremap <leader>gc :Gcommit <CR>


"Buffer 
nnoremap <leader>l :bn<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader>q :bd<CR>

nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>


func! Exc()
	let curr_file = expand('%:e')
	if curr_file == "c" || curr_file == "cpp" || curr_file == "hs" || curr_file == "cc"
		exec "!./%<"
	elseif curr_file == "py"
		exec ":w"
		exec "! python3 %"
	elseif curr_file == "tex"
		exec "silent ! zathura %<.pdf > /dev/null 2>&1 &"
		exec ":redraw!"
	elseif curr_file == "ng"
		exec "!ngspice ./%"
		exec ":redraw!"
	elseif curr_file == "m"
		exec "!octave ./%"
    elseif curr_file == "html"
        exec "silent !firefox ./% > /dev/null 2>&1 &"
        exec ":redraw!"
    elseif curr_file == "gv"
        exec "silent ! eog ./%<.png > /dev/null 2>&1 &"
        exec ":redraw!"
    elseif curr_file == "vim"
        exec ":source %"
	endif
endfunc

func! Exc_with_fin()
	exec "!./%< < %<.in"
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
let g:syntastic_cpp_compiler_options = ' -std=c++11 -Wall -Wshadow'

if has("gui_running")
    set guioptions-=T "remove toolbar
    set guioptions-=m "remove menubar
    set guioptions-=r "remove scrollbar
endif
set guifont=monospace\ 18
