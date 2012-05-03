" author: Sam Rose <samwho@lbak.co.uk>

set background=dark

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'scheme_name'

if version < 700
  finish
endif

highlight Normal gui=bold,italic guifg=#ffffff guibg=#000000 cterm=bold,italic ctermfg=NONE ctermbg=NONE
