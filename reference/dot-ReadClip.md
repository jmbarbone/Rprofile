# Read the clipboard

Reads the clipboard and returns the contents as a character vector or
table

## Usage

``` r
.ReadClip(convert = c("auto", "none", "some", "data.frame", "tibble"), ...)
```

## Arguments

- convert:

  The method to use.

  - `"auto"`: (default) Parses contents either into a vector and applies
    some conversion; if multiple lines are detected, attempts to parse
    as a table

  - `"none"`: Returns the contents as a string

  - `"some"`: Returns the contents as a character vector and performs
    some parsing to possibly convert to a vector

  - `"data.frame"`: Returns the contents as a data frame (via
    [`clipr::read_clip_tbl()`](http://matthewlincoln.net/clipr/reference/read_clip_tbl.md))

- ...:

  Additional arguments passed to
  [`utils::read.table()`](https://rdrr.io/r/utils/read.table.html)
  (defaults have been changed)

## Details

Essentially wraps
[`clipr::read_clip()`](http://matthewlincoln.net/clipr/reference/read_clip.md)
