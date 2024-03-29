set nocompatible
filetype off

set rtp+=~/.vim/vundle
call vundle#begin()

Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'rollxx/vim-antlr'
Plugin 'vintikzzz/vim-bundler'
Plugin 'asux/vim-capybara'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-endwise'
Plugin 'oscarh/vimerl'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-haml'
Plugin 'wlangstroth/vim-haskell'
Plugin 'jcf/vim-latex'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rvm'
Plugin 'tsaleh/vim-supertab'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/VimClojure'
Plugin 'vim-scripts/Vim-R-plugin'
Plugin 'tpope/vim-repeat'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/vimwiki'
Plugin 'altercation/vim-colors-solarized'
Plugin 'rodjek/vim-puppet'
Plugin 'vim-scripts/cscope.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'helino/vim-nasm'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

call vundle#end()

" let g:solarized_termcolors = 16
syntax enable
set background=dark
colorscheme solarized

" Load plugins.
if has("autocmd")
    filetype plugin indent on
endif

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
set fo+=t                 " Automatically wrap long lines
set noswapfile            " Don't bother with swap files.
set ignorecase
set smartcase
set pastetoggle=,p        " Toggle paste mode, which allows you to paste as-is
set laststatus=2
set termencoding=utf-8
set encoding=utf-8
set backspace=indent,eol,start

" Session management
let g:session_default_name = getcwd()
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
let g:session_autosave_periodic = 'yes'

function SaveAndCloseSession()
    SaveSession
    CloseSession
endfunction

autocmd! VimLeave * call SaveAndCloseSession()

" For ctrlp.vim to work correctly
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Map my leader key
let mapleader=','

" Tabular mappings
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" Visual dot map
:vnoremap . :norm.<CR>

" Set the formatting program to par
if executable("par")
    set formatprg=par\ -w80\ -r\ -j
endif

" 80 columns marker
if exists('+colorcolumn')
  set colorcolumn=+1
endif

" Spell checking on text files.
if v:version >= 700
    " Enable spell check for text files.
    autocmd! BufNewFile,BufRead *.txt,*.md,*.markdown,*.mdown,*.tex setlocal spell spelllang=en_gb
endif

" Improved status line
set statusline=%F%m%r%h%w\ [ftype=%Y]\ [pos=%p%%][l:%l/c:%v]\ [lines=%L]\ %{fugitive#statusline()}

" Syntastic settings.
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['tex', 'java'] }
let g:syntastic_c_compiler = 'clang'
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '`llvm-config --cppflags --ldflags --libs core`'


" Some time savers.
command! WQ wq
command! Wq wq
command! W w
command! Q q

" This abbreviation replaces the :q command with :qall.
cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'qall' : 'q')<CR>

" Some autocorrection for common typos
iab anf and
iab adn and
iab ans and
iab teh the
iab thre there

" LaTeX configs
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Settings for VimClojure
let vimclojure#HighlightBuiltins=1
let vimclojure#ParenRainbow=1


" Strip trailing whitespace before writing buffer to file.
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Maps for window resizing
noremap <silent> <Left> <C-w><
noremap <silent> <Down> <C-W>-
noremap <silent> <Up> <C-W>+
noremap <silent> <Right> <C-w>>

noremap <silent> <C-n> <C-w><C-w>

" Maps for natural navigation of long lines
nnoremap j gj
nnoremap k gk

" Fugitive stuff. Delete a fugitive buffer upon leaving it.
autocmd! BufReadPost fugitive://* set bufhidden=delete

" Source a given file or fail out.
function! LoadFile(filename)
    let FILE=expand(a:filename)
    if filereadable(FILE)
        exe "source " FILE
    else
        " echo "Can't source " FILE
    endif
endfunction

" Stop screen trying to hijack .S files.
let vimrplugin_screenplugin = 0

" Syntax highlight in codeblocks in markdown
let g:markdown_fenced_languages = ['ruby', 'vim']

" Load the .vimrc.local file if it exists.
exec LoadFile("~/.vimrc.local")
