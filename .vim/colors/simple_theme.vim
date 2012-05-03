set background=dark

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'simple_theme'

highlight Normal gui=NONE guifg=#ffffff guibg=NONE cterm=NONE ctermfg=231 ctermbg=NONE
highlight rubyConstant gui=bold guifg=#ff0000 guibg=NONE cterm=bold ctermfg=196 ctermbg=NONE
