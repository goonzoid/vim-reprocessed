# reprocessed.vim

A plugin to make it easier to work with the Processing language in vim.
It is originally based on
[sophacles/vim-processing](https://github.com/sophacles/vim-processing),
which was in turn an extension of vim script
[#2115](http://www.vim.org/scripts/script.php?script_id=2115).

Please note that this plugin has currently only been tested on OS X.
I would love to hear from you if you use this plugin (successfully or
otherwise) on Windows or Linux.

## Features

* Syntax highlighting
* Documentation lookup
* Run sketches from within vim

## Installation

If you're not using either [Vundle](https://github.com/gmarik/vundle)
or [Pathogen](https://github.com/tpope/vim-pathogen),
I highly recommend that you check them out.

### Install with Vundle

Add this to your vimrc in the appropriate place:

    Bundle "willpragnell/vim-reprocessed"

Then install:

    :so ~/.vimrc
    :BundleInstall

### Install with Pathogen

Just clone it:

    cd ~/.vim/bundle
    git clone https://github.com/willpragnell/vim-reprocessed.git

## Looking up documentation

This feature requires that your vim has been compliled with python support.
Simply move the cursor to the keyword you would like to look up and hit 'K' in
normal mode. Note that words followed by an opening paren '(' are treated as
functions, so `frameRate()` and `frameRate` will go to different pages in the
documentation.

By default, reprocessed will try to look up documentation online. However, you
can configure it to access local documentation by adding the following line to
your .vimrc:

    let processing_doc_path="/path/to/processing/docs/on/your/machine"

Of course, you'll want to replace the path with the actual path on your machine.
In some cases, I have seen this fail to work on OS X when attempting to link to
the documentation within the Processing.app application bundle. The solution is
to make a copy of that documentation elsewhere on the filesystem.

## Running sketches

This feature requires the `processing-java` command to be available in your
`PATH`. On Linux & Windows you'll need to add it manually, but on OS X you should
be able to install this from within Processing.app. See the [Processing wiki]
(http://wiki.processing.org/w/Command_Line) for more information.

__WARNING:__ If you have a directory inside your sketch directory called "bin"
then it will be destroyed when you run your sketch using this method unless you
have explicitly configured reprocessed to use a different path.
If you want to specify the output directory for `processing-java` to some path
other than "bin", then you can do so with one the following lines in your .vimrc:

    let processing_output_dir="path/relative/to/sketch"

    let processing_output_dir="/absolute/path"

Paths without a leading `/` will be set relative to your sketch directory, in
contrast to paths that start wtih a `/` which will be read as absolute paths.

__WARNING:__ reprocessed will run `processing-java` with the `--force` option, so
this directory will get nuked every time you run your sketch. Do not set this path
to a directory which contains files you care about. __You have been warned!__

One other requirement is that your directory structure follow the pattern that
Processing expects: your sketch file should have the same name as the directory
in which it exists. If you created your sketch using the Processing app then
this is unlikely to be an issue, but it's something to be aware of if you're
creating new sketches in vim.

You can run your sketchs normally by hitting `<leader>r`, or run them full screen
with `<leader>p`. These commands will save the file before running it. I highly
recommend that you use version control to manage your sketches so that you don't
lose any work. If you wish to disable or reconfigure these keyboard mappings,
please see the section below.

## Key mappings

By default, reprocessed will map `<leader>r` and `<leader>p` to run your sketch.
If you wish to disable these mappings because they conflict with your own custom
mappings, add the following line to your .vimrc:

    let g:reprocessed_map_keys = 0

If you wish to map some other keys to run sketches, the functions you need to
map to are `:RunCurrentSketch` and `:PresentCurrentSketch`. So, for example, you
may want something like the following:

    nnoremap <leader>1 :RunCurrentSketch<cr>
    nnoremap <leader>2 :PresentCurrentSketch<cr>

Check out the vim help if you want to know about how mappings work or how to
make these mappings only for `.pde` files.

## TODO

* Cleanup and update syntax file for Processing 2
* Dash integration (possibly using
  [dash.vim](https://github.com/rizzatti/dash.vim))
* Support for running in javascript mode
* Add license
* Proper help/documentation

