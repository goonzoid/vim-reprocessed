if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal suffixesadd=.pde
setlocal commentstring=//\ %s
let b:undo_ftplugin = "setlocal sua< cms<"

" Run sketches from within vim
function! ProcessingOutputDir()
  if exists("g:processing_output_dir")
    let output_dir = g:processing_output_dir
    let has_leading_slash = match(output_dir, "/") == 0
    if !has_leading_slash
      let output_dir = "%:p:h/".output_dir
    endif
  else
    let output_dir = "%:p:h/bin"
  endif
  return output_dir
endfunction

function! SaveAndExecuteSketch(action)
  let cmd_string_template = ":silent !processing-java --sketch=%:p:h --output={0} --force --".a:action
  let cmd_string = substitute(cmd_string_template, "{0}", ProcessingOutputDir(), "")
  :w
  exec cmd_string
  :redraw!
endfunction

command! RunCurrentSketch call SaveAndExecuteSketch("run")
command! PresentCurrentSketch call SaveAndExecuteSketch("present")

" Documentation lookup
if has("python")
  if exists("g:processing_doc_path")
    let g:processing_doc_style = "local"
  else
    let g:processing_doc_style = "web"
  endif

  function! ProcessingDoc()
    if !exists("s:processing_doc_py_path")
      let paths = substitute(escape(&runtimepath, ' '), '\(,\|$\)', '/**\1', 'g')
      let s:processing_doc_py_path = findfile('processing_doc.py', paths)
      if !filereadable(s:processing_doc_py_path)
        echohl WarningMsg
        echom "Could not find processing_doc.py in your vim runtime path"
        echohl None
        unlet s:processing_doc_py_path
        return
      endif
    endif
    execute "pyfile ".s:processing_doc_py_path
  endfunction
  nnoremap <silent> <buffer> K :call ProcessingDoc()<cr>
else
  echohl WarningMsg
  echom "reprocessed.vim processing documentation lookup requires vim to be compiled with python support"
  echohl None
endif

" Key mappings
if !exists('g:reprocessed_map_keys')
  let g:reprocessed_map_keys = 1
endif

if g:reprocessed_map_keys
  nnoremap <buffer> <leader>r :RunCurrentSketch<cr>
  nnoremap <buffer> <leader>p :PresentCurrentSketch<cr>
endif
