if (exists("b:did_indent"))
  finish
endif
let b:did_indent = 1

setlocal cindent
setlocal cinkeys-=0#
setlocal formatoptions-=t formatoptions+=croql
let b:undo_indent = "setlocal cin< cink< fo<"

