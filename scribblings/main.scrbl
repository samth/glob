#lang scribble/manual
@require[racket/include]
@require[scribble/eval]
@defmodule[glob]

@title[#:tag "top"]{@bold{Glob: Unix-Stle globbing in Racket}}
@author[@hyperlink["https://github.com/bennn"]{Ben Greenman}]

A glob is like a path string, but allows wildcard characters.
This library brings Unix-style globbing to Racket.

@section{API Functions}

@defproc[(glob [glob-string string] [dotfiles? #f]) (listof path-string)]{
  Builds a list of all paths matched by the glob @code{glob-string}.
  Dotfiles are filtered by default unless matched for explicitly.
  Set the optional argument to @code{#t} to override this behavior.
}

@defproc[(in-glob [glob-string string] [dotfiles? #f]) (sequenceof path-string)]{
  Returns a sequence of all paths matched by the glob @code{glob-string}, rather than storing each match explicitly in a list.
  When the optional argument is @code{#t}, returns all matching results including dotfiles.
}

The matches returned by either function should be exactly the same as those returned by the Unix glob @code{file \. -name glob-path-string}.
Please submit an issue if you find a counterexample.

@section{Globbing 101}

Globs are path strings that may contain the following special characters.

@itemlist[
@item{
  @code{*} is a wildcard.
  It means "match anything".
  For example, @code{(glob "*.rkt")} will match all files in the current directory with a @code{.rkt} file extension.
}
@item{
  @code{?} is an option.
  It means "the previous character might not be there".
  For example, @code{(glob "*.rktd?")} will match all @code{.rkt} and all @code{.rktd} files in the current directory.
}
@item{
  Square braces @code{[]} are for branching on single characters.
  The pattern @code{[abc]} means "match 'a', or match 'b', or match 'c'".
  For example, @code{(glob "*.[co]")} will match all @code{.c} and all @code{.o} files in the current directory.
}
]
Aside from these pattern variables, a glob is just a path-string.

