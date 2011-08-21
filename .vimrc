" Syntax highlighting on
syntax on

set t_Co=256 " Make my colour scheme work in the command line.
colors zenburn " Set colour scheme to zenburn.

set go-=m             " Hide menu (gvim).
set go-=T             " Hide toolbar (gvim).
set nu!               " Line numbers.
set hidden            " Hide buffers when switching rather than closing them.
set guifont=Mono\ 12  " (gvim).
set tabstop=4         " Four spaces to a tab.
set softtabstop=4
set shiftwidth=4      " Number of spaces to use for autoindenting.
set expandtab
set autoindent        " Automatically indent.
set copyindent        " Copy the previous line's indenting.
set showmatch         " Show matching parenthesis.
set hlsearch          " Highlight search terms.
set incsearch         " Show search matches incrementally.
set list              " Shows tabs (^I) and end of line ($).
set history=1000      " Commands and search history.
set undolevels=1000   " Lots of undo levels.
set autowrite         " Write changed buffers before :make.
set wildmenu          " Wildmenu rocks.
set shiftround        " always round indents to multiple of shiftwidth.

" Get rid of the .swp files from my working dir.
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

set scrolloff=5 " Keep at least 5 lines above and below.
set sidescrolloff=5 " Keep at least 5 chars left and right.

" spelling
if v:version >= 700
  " Enable spell check for text files.
  autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en
endif

" Syntastic settings.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1

" Some time savers.
:command WQ wq
:command Wq wq
:command W w
:command Q q

iab anf and
iab adn and
iab ans and
iab teh the
iab thre there

" Load plugins.
filetype plugin indent on

" Turn omni complete on.
set ofu=syntaxcomplete#Complete

" Ruby specific settings.
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby set tabstop=2 " Two spaces to a tab.
autocmd FileType ruby,eruby set softtabstop=2
autocmd FileType ruby,eruby set shiftwidth=2 " Number of spaces to use for autoindenting.

" Improve autocomplete menu color.
highlight Pmenu ctermbg=238 gui=bold

" Hide special characters (like ^I).
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Auto compile a file on save for learning C (temporary).
autocmd BufWritePost,FileWritePost p*.c !gcc --ansi -Wall <afile> -o exec

" Strip trailing whitespace before writing buffer to file.
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position.
  let @/=_s
  call cursor(l, c)
endfunction
