call pathogen#infect()    " Init pathogen
call pathogen#helptags()
syntax on                 " Syntax highlighting on
set t_Co=256              " Make my colour scheme work in the command line.
colors distinguished
set go-=m                 " Hide menu (gvim).
set go-=T                 " Hide toolbar (gvim).
set nu                    " Line numbers.
set hidden                " Hide buffers when switching rather than closing them.
set tabstop=4             " Four spaces to a tab.
set softtabstop=4
set shiftwidth=4          " Number of spaces to use for autoindenting.
set expandtab
set autoindent            " Automatically indent.
set copyindent            " Copy the previous line's indenting.
set showmatch             " Show matching parenthesis.
set hlsearch              " Highlight search terms.
set incsearch             " Show search matches incrementally.
"set list                 " Shows tabs (^I) and end of line ($).
set history=1000          " Commands and search history.
set undolevels=1000       " Lots of undo levels.
set autowrite             " Write changed buffers before :make.
set wildmenu              " Wildmenu rocks.
set shiftround            " always round indents to multiple of shiftwidth.
set backup                " Get rid of the .swp files from my working dir.
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set scrolloff=5           " Keep at least 5 lines above and below.
set sidescrolloff=5       " Keep at least 5 chars left and right.
set textwidth=80          " The maximum number of characters a line should be.

" 80 columns marker
if exists('+colorcolumn')
  set colorcolumn=80
endif

" Spell checking on text files.
if v:version >= 700
    " Enable spell check for text files.
    autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en
endif

" Improved status line
set statusline=%F%m%r%h%w\ [ftype=%Y]\ [pos=%p%%][l:%l/c:%v]\ [lines=%L]\ %{fugitive#statusline()}
set laststatus=2

" Syntastic settings.
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1

" Some time savers.
command! WQ wq
command! Wq wq
command! W w
command! Q q

" Some autocorrection for common typos
iab anf and
iab adn and
iab ans and
iab teh the
iab thre there

" Load plugins.
filetype plugin indent on

" Turn omni complete on.
set ofu=syntaxcomplete#Complete

" LaTeX configs
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Improve autocomplete menu color.
highlight Pmenu ctermbg=238 gui=bold

" Auto compile a file on save for learning C (temporary).
" autocmd BufWritePost,FileWritePost p*.c !gcc --ansi -Wall <afile> -o exec

" Strip trailing whitespace before writing buffer to file.
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    if &modifiable
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        %s/\s\+$//e
        " Clean up: restore previous search history, and cursor position.
        let @/=_s
        call cursor(l, c)
    endif
endfunction

" Maps for window resizing
noremap <silent> <Left> <C-w><
noremap <silent> <Down> <C-W>-
noremap <silent> <Up> <C-W>+
noremap <silent> <Right> <C-w>>
" Maps Ctrl-[s.v] to horizontal and vertical split respectively
" noremap <silent> <C-s> :split<CR>
" noremap <silent> <C-v> :vsplit<CR>
" Maps Ctrl-[n,p] for moving next and previous window respectively
noremap <silent> <C-n> <C-w><C-w>
noremap <silent> <C-p> <C-w><S-w>

" Fugitive stuff. Delete a fugitive buffer upon leaving it.
autocmd BufReadPost fugitive://* set bufhidden=delete

" Source a given file or fail out.
function! LoadFile(filename)
    let FILE=expand(a:filename)
    if filereadable(FILE)
        exe "source " FILE
    else
        " echo "Can't source " FILE
    endif
endfunction

" Load the .vimrc.local file if it exists.
exec LoadFile("~/.vimrc.local")
