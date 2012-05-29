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
set fo+=t                 " Automatically wrap long lines

" Load plugins.
if has("autocmd")
    filetype plugin indent on
endif

" Map my leader key
let mapleader=','

" Tabular mappings
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" Only define the ReloadVimrc file once. This is for use in the auto command
" that reloads the vimrc file when you save the vimrc file. It places the cursor
" exactly where it was before save, instead of having the cursor back at the top
" after sourcing.
if !exists("*ReloadVimrc")
    function ReloadVimrc()
        let l = line(".")
        let c = col(".")
        source $MYVIMRC
        call cursor(l, c)
    endfunction
endif

" Source my .vimrc file after changes have been made to it.
autocmd! BufWritePost .vimrc :call ReloadVimrc()

" Keybinding for quickly opening my vimrc file for editing
nmap <Leader>v :vsp $MYVIMRC<CR>

" Set the formatting program to par
set formatprg=par\ -w80\ -r\ -j

" 80 columns marker
if exists('+colorcolumn')
  set colorcolumn=80
endif

" Spell checking on text files.
if v:version >= 700
    " Enable spell check for text files.
    autocmd! BufNewFile,BufRead *.txt,*.md,*.markdown,*.tex setlocal spell spelllang=en_gb
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
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['tex'] }


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

" Auto compile a file on save for learning C (temporary).
" autocmd BufWritePost,FileWritePost p*.c !gcc --ansi -Wall <afile> -o exec

" Strip trailing whitespace before writing buffer to file.
autocmd! BufWritePre * :call <SID>StripTrailingWhitespaces()

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
autocmd! BufReadPost fugitive://* set bufhidden=delete

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Source a given file or fail out.
function! LoadFile(filename)
    let FILE=expand(a:filename)
    if filereadable(FILE)
        exe "source " FILE
    else
        " echo "Can't source " FILE
    endif
endfunction

" Loads the session from the current directory if, and only if, no file names
" were passed in via the command line.
function! LoadSession()
    if argc() == 0
        exe LoadFile(".session.vim")
    endif
endfunction

" Auto session management commands
autocmd! VimLeave * mksession! .session.vim
autocmd! VimEnter * :call LoadSession()

" Load the .vimrc.local file if it exists.
exec LoadFile("~/.vimrc.local")
