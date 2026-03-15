# TODOs and FIXMEs

`.Todos()` and `.Fixmes()` default to recursively searching the path
`"."` and can be changed with setting `path` in `...`. `.TodosHere()`
and `.FixmesHere()` try to search the active file, found with the use of
`Rstudio`.

## Usage

``` r
.Todos(..., .quiet = FALSE, .space = FALSE)

.Fixmes(..., .quiet = FALSE)

.TodosHere(..., .quiet = FALSE)

.FixmesHere(..., .quiet = FALSE)
```

## Arguments

- ...:

  additional arguments pass to \`mark::todos“

- .quiet:

  If `TRUE` doesn't print result

- .space:

  If `TRUE` adds another `"\n"` to the output

## Value

See
[`?mark::todos`](https://jmbarbone.github.io/mark/reference/todos.html)

## Details

Get a list of TODOs and FIXMEs
