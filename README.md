# reprocessed.vim

A plugin to make it easy to work with the Processing language.
It is originally based on
[sophacles/vim-processing](https://github.com/sophacles/vim-processing),
which was in turn an extension of vim script
[#2115](http://www.vim.org/scripts/script.php?script_id=2115).

## Features

* Run sketches from within vim (experimental and potentially dangerous,
read below for more info)

### Running sketches from within vim

__WARNING:__ If you have a directory inside your sketch directory called `bin`
then it will be destroyed when you run your sketch using this method. This is
because `processing-java` requires an output directory to be specified, which
reprocessed specifies as `bin` in the same directory of your sketch.
`processing-java` will stomp on this directory without warning because we're
using the `--force` option, which is required to prevent you having to delete
the directory manually after each run. I plan to make this path configurable
at some point in the future, but until then, __you have been warned!__

This feature requires the `processing-java` command to be available in your
PATH. On Linux & Windows you'll need to add it manually, but on OS X you should
be able to install this from within the Pocessing app. See the [processing wiki]
(http://wiki.processing.org/w/Command_Line) for more information.

Another requirement is that your directory structure follow the pattern that
Processing expects: your sketch file should have the same name as the directory
in which it exists. If you created your sketch using the Processing app then
this is unlikely to be an issue, but it's something to be aware of if you're
creating new sketches in vim.

You should be able to run your sketchs using `<leader>r`. This will save the file
before running it. I highly recommend that you use version control to manage your
sketches so that you don't lose any work. There are plans to make the key command
used to run sketches configurable in the future.

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

## TODO

* Cleanup and update syntax file for Processing 2
* Make processing-java output path configurable
* Make processing-java run key command configurable

