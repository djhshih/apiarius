# apiarius

This project automates downloading databases from online resources.
It provides one command (`mella`) for choosing which database to download, and
code for downloading each database are available as individual
Makefiles, possibly accompanied by some preprocessing scripts.

## Requirements

- make, coreutils, grep, curl, wget
- R, biomaRt

## Install

First, place the contents of this project somewhere permanent, because
the scripts herein will be needed by the main program

Then, install `mella` to `/usr/local/bin` by

   ./install.sh

To install `mella` elsewhere, define `DESTDIR` another directory

    DESTDIR=/usr/local ./install.sh

## Usage

Define the environmental variable `APIARIUS_DATA` to point to where you want the
data files to be stored. Otherwise, this variable defaults to `$HOME/data`.

Then, you install a database such as `orthocml` by the following command

    mella get orthocml

The data will be downloaded and preprocessed according to default parameters. In
the spirit of reproducible research, a preprocessed Makefile will 
copied to the target directory. This Makefile will have optional
parameters defined to the values passed on the command line.

To see a list of optional parameters, you can do

    mella args orthocml

And you can pass optional parameters using the `variable=value` syntax (no space
is allowed).

    mella args orthocml species_src=drerio species_src_sh=drer

Additionally, You may get a list of available databases by

    mella list

## Contributing

To automate the download of a database not already provided, you would need to
write a Makefile. If the Makefile depends on custom scripts, you can put them in
the same directory as the Makefile, and add the following definition to the top
of the line

    path ?= .

This defines a variable Makefile `path` that defaults to the current directory.
To execute a script such as `process.py`, you would write

    $(path)/process.py

This `path` variable will be modified as necessary when the Makefile is
preprocessed.

Here, `path` is an optional argument in the usual Makefile syntax. If your
Makefile works when you do `make` in the directory where the Makefile resides,
it will work with `mella` in any directory.

You can also define additional optional arguments at the top of your Makefile.
Any optional arguments defined in the first block of the file (i.e. before the
first blank line) will be exposed to the user, who may modify these arguments
when using `mella`.

