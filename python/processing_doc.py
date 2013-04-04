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

def isFunction():
    (row, col) = vim.current.window.cursor
    line = vim.current.line
    col = wordStart(line, col)
    if re.match(r"\w+\s*\(", line[col:]):
        if col < 4:
            return True
        else:
            col -= 4
            if re.match(r"new\s*\w+\s*\(", line[col:]):
                return False
            else:
                return True
    else:
        return False

if vim.eval("g:processing_doc_style") == "local":
    basepath = path.abspath(vim.eval("g:processing_doc_path"))
    launchDoc = launchDocFile
else:
    launchDoc = launchDocWeb

word = vim.eval('expand("<cword>")')
if word:
    if isFunction():
        success = launchDoc(word + "_.html") or launchDoc(word + ".html")
    else:
        success = launchDoc(word + ".html") or launchDoc(word + "_.html")
    if not success:
        print "Identifier", '"' + word + '"', "not found in local documentation."

