# Lint a single file

Use [`lintr::lint()`](https://lintr.r-lib.org/reference/lint.html) to
*lint* a single file

## Usage

``` r
.LintFile(
  path = NULL,
  linters = NULL,
  ...,
  config = Sys.getenv("LINTR_GLOBAL_CONFIG", NA)
)
```

## Arguments

- path:

  The file path. Default (`NULL`) checks for the current file open in
  the source editor in **RStudio**.

- linters:

  Passed to `linters` argument in
  [`lintr::lint()`](https://lintr.r-lib.org/reference/lint.html);
  however, when passing a character vector, finds all linters with that
  tag.

- ...:

  Additional arguments passed to
  [`lintr::lint()`](https://lintr.r-lib.org/reference/lint.html)

- config:

  Global configuration file; when `NA` does nothing

## Value

See [`lintr::lint()`](https://lintr.r-lib.org/reference/lint.html)
