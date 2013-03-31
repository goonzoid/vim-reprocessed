" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal cindent
setlocal cinkeys-=0#
setlocal formatoptions-=t formatoptions+=croql
setlocal suffixesadd=.pde
setlocal commentstring=//\ %s

nmap <buffer> <leader>r :w\|:!processing-java --sketch=%:p:h --output=%:p:h/bin --force --run<cr>

let b:undo_ftplugin = "set cin< cink< fo< sua< et< sw< ts<"

if has("python")
  if !exists("g:processing_doc_path")
    let g:processing_doc_style = "web"
  else
    let g:processing_doc_style = "local"
  endif

  function! ProcessingDoc()
python << ENDPY
import vim
import re
import webbrowser
from os import path

def launchDocFile(filename):
  docfile = path.join(basepath, filename)
  if path.exists(docfile) and path.isfile(docfile):
    webbrowser.open("file://" + docfile)
    return True
  return False

def launchDocWeb(filename):
  docfile = "http://processing.org/reference/"
  webbrowser.open(docfile+filename)
  return True

def wordStart(line, column):
  start = column
  for i in reversed(range(column)):
    if line[i].isalnum():
      start = i
    else:
      break
  return start

if vim.eval("g:processing_doc_style") == "local":
  basepath = path.abspath(vim.eval("g:processing_doc_path"))
  launchDoc = launchDocFile
else:
  launchDoc = launchDocWeb

(row, col) = vim.current.window.cursor
line = vim.current.line

col = wordStart(line, col)
if re.match(r"\w+\s*\(", line[col:]):
  if col < 4:
    isFunction = True
  else:
    col -= 4
    if re.match(r"new\s*\w+\s*\(", line[col:]):
      isFunction = False
    else:
      isFunction = True
else:
  isFunction = False

word = vim.eval('expand("<cword>")')

if word:
  if isFunction:
    success = launchDoc(word + "_.html") or launchDoc(word + ".html")
  else:
    success = launchDoc(word + ".html") or launchDoc(word + "_.html")
  if not success:
    print "Identifier", '"' + word + '"', "not found in local documentation."

ENDPY
  endfunction

nnoremap <silent> <buffer> K :call ProcessingDoc()<CR>

endif "has("python")

