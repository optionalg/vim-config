" Vim syntax file
" Language:	Parrot IMCC
" Maintainer:	Luke Palmer <fibonaci@babylonia.flatirons.org>
" Modified: Joshua Isom
" Last Change:	Jan 6 2006

" For installation please read:
" :he filetypes
" :he syntax
"
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
"
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax clear

syn include @Pod syntax/pod.vim
syn region pirPod start="^=[a-z]" end="^=cut" keepend contains=@Pod fold

syn keyword pirType int float num string pmc
syn match   pirPMC  /\.\(Compiler\|Continuation\|Coroutine\|CSub\|NCI\|Eval\|Sub\|Scratchpad\)/
syn match   pirPMC  /\.\(BigInt\|Boolean\|Complex\|Float\|Integer\|PMC\|String\|Hash\)/
syn match   pirPMC  /\.\(Fixed\|Resizable\)\(Boolean\|Float\|Integer\|PMC\|String\)Array/
syn match   pirPMC  /\.\(IntList\|Iterator\|Key\|ManagedStruct\|UnManagedStruct\|Pointer\)/
syn match   pirPMC  /\.\(FloatVal\|Multi\|S\|String\)\?Array/
syn match   pirPMC  /\.Perl\(Array\|Env\|Hash\|Int\|Num\|Scalar\|String\|Undef\)/
syn match   pirPMC  /\.Parrot\(Class\|Interpreter\|IO\|Library\|Object\|Thread\)/
syn keyword pirPMC self

syn keyword pirOp   goto if unless global addr

syn match pirDirectiveSub    /\.\(sub\|end\s*$\)/
syn match pirDirectiveMacro  /\.\(macro\|endm\)/
syn match pirDirective  /\.\(pcc_sub\|emit\|eom\)/
syn match pirDirective  /\.\(local\|sym\|const\|lex\|global\|globalconst\)/
syn match pirDirective  /\.\(endnamespace\|namespace\)/
syn match pirDirective  /\.\(param\|arg\|return\|yield\)/
syn match pirDirective  /\.\(pragma\|HLL\|include\|loadlib\)/
syn match pirDirective  /\.\(pcc_begin\|pcc_call\|pcc_end\|invocant\|meth_call\|nci_call\)/
syn match pirDirective  /\.\(pcc_begin_return\|pcc_end_return\)/
syn match pirDirective  /\.\(pcc_begin_yield\|pcc_end_yield\)/

syn match pirDirective  /:\(main\|method\|load\|init\|anon\|multi\|immediate\|outer\|lex\|vtable|nsentry\|subid\)/
syn match pirDirective  /:\(flat\|slurpy\|optional\|opt_flag\|named\)/

" Macro invocation
syn match pirDirective  /\.\I\i*(/he=e-1


" pirWord before pirRegister
" FIXME :: in identifiers and labels
syn match pirWord           /[A-Za-z_][A-Za-z0-9_]*/
syn match pirComment        /#.*/
syn match pirLabel          /[A-Za-z0-9_]\+:/he=e-1
syn match pirRegister       /[INPS]\([12][0-9]\|3[01]\|[0-9]\)/
syn match pirDollarRegister /\$[INPS][0-9]\+/

syn match pirNumber         /[+-]\?[0-9]\+\(\.[0-9]*\([Ee][+-]\?[0-9]\+\)\?\)\?/
syn match pirNumber         /0[xX][0-9a-fA-F]\+/
syn match pirNumber         /0[oO][0-7]\+/
syn match pirNumber         /0[bB][01]\+/

syn region pirString start=/"/ skip=/\\"/ end=/"/ contains=pirStringSpecial
syn region pirString start=/<<"\z(\I\i*\)"/ end=/^\z1$/ contains=pirStringSpecial
syn region pirString start=/<<'\z(\I\i*\)'/ end=/^\z1$/
syn region pirString start=/'/ end=/'/
syn match  pirStringSpecial "\\\([abtnvfre\\"]\|\o\{1,3\}\|x{\x\{1,8\}}\|x\x\{1,2\}\|u\x\{4\}\|U\x\{8\}\|c[A-Z]\)" contained

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_pasm_syntax_inits")
  if version < 508
    let did_pasm_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink pirPod             Comment
  HiLink pirWord            Normal
  HiLink pirComment         Comment
  HiLink pirLabel           Label
  HiLink pirRegister        Identifier
  HiLink pirDollarRegister  Identifier
  HiLink pirType            Type
  HiLink pirPMC             Type
  HiLink pirString          String
  HiLink pirStringSpecial   Special
  HiLink pirNumber          Number
  HiLink pirDirective       Macro
  HiLink pirDirectiveSub    Macro
  HiLink pirDirectiveMacro  Macro
  HiLink pirOp              Conditional

  delcommand HiLink
endif

let b:current_syntax = "pir"

" Folding rules
syn region foldManual  start=/^\s*#.*{{{/ end=/^\s*#.*}}}/ contains=ALL keepend fold
syn region foldMakro   start=/\.macro/ end=/^\s*\.endm/ contains=ALLBUT,pirDirectiveMacro keepend fold
syn region foldSub     start=/\.sub/ end=/^\s*\.end/ contains=ALLBUT,pirDirectiveSub,pirDirectiveMacro keepend fold
syn region foldIf      start=/^\s*if.*goto\s*\z(\I\i*\)\s*$/ end=/^\s*\z1:\s*$/ contains=ALLBUT,pirDirectiveSub,pirDirectiveMacro keepend fold
syn region foldUnless  start=/^\s*unless.*goto\s*\z(\I\i*\)\s*$/ end=/^\s*\z1:\s*$/ contains=ALLBUT,pirDirectiveSub,pirDirectiveMacro keepend fold

" Ops -- dynamically generated from ops2vim.pl
syn keyword pirOp band bor shl shr lsr bxor eq eq_str eq_num eq_addr ne
syn keyword pirOp ne_str ne_num ne_addr lt lt_str lt_num le le_str le_num
syn keyword pirOp gt gt_str gt_num ge ge_str ge_num if_null unless_null
syn keyword pirOp cmp cmp_str cmp_num cmp_pmc issame isntsame istrue
syn keyword pirOp isfalse isnull isgt isge isle islt iseq isne and not or
syn keyword pirOp xor end noop check_events check_events__ wrapper__
syn keyword pirOp load_bytecode load_language branch local_branch
syn keyword pirOp local_return jump enternative if unless invokecc invoke
syn keyword pirOp yield tailcall returncc capture_lex newclosure set_args
syn keyword pirOp get_params set_returns get_results set_result_info
syn keyword pirOp result_info set_addr get_addr schedule addhandler
syn keyword pirOp push_eh pop_eh throw rethrow count_eh die exit finalize
syn keyword pirOp debug bounds profile trace gc_debug interpinfo
syn keyword pirOp warningson warningsoff errorson errorsoff runinterp
syn keyword pirOp getinterp sweep collect sweepoff sweepon collectoff
syn keyword pirOp collecton needs_destroy loadlib dlfunc dlvar compreg
syn keyword pirOp new_callback annotations trap set_label get_label fetch
syn keyword pirOp vivify new root_new print say getstdin getstdout
syn keyword pirOp getstderr abs add dec div fdiv ceil floor inc mod mul
syn keyword pirOp neg sub sqrt callmethodcc callmethod tailcallmethod
syn keyword pirOp addmethod can does isa newclass subclass get_class
syn keyword pirOp class addparent removeparent addrole addattribute
syn keyword pirOp removeattribute getattribute setattribute inspect
syn keyword pirOp typeof get_repr find_method defined exists delete
syn keyword pirOp elements push pop unshift shift splice setprop getprop
syn keyword pirOp delprop prophash freeze thaw add_multi find_multi
syn keyword pirOp register unregister box iter morph clone set assign
syn keyword pirOp setref deref copy null ord chr chopn concat repeat
syn keyword pirOp length bytelength pin unpin substr replace index
syn keyword pirOp sprintf stringinfo upcase downcase titlecase join split
syn keyword pirOp encoding encodingname find_encoding trans_encoding
syn keyword pirOp is_cclass find_cclass find_not_cclass escape compose
syn keyword pirOp find_codepoint spawnw err time sleep store_lex
syn keyword pirOp store_dynamic_lex find_lex find_dynamic_lex
syn keyword pirOp find_caller_lex get_namespace get_hll_namespace
syn keyword pirOp get_root_namespace get_global get_hll_global
syn keyword pirOp get_root_global set_global set_hll_global
syn keyword pirOp set_root_global find_name find_sub_not_null
