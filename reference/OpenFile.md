# Open (as) File

Open a file path or data as a file

## Usage

``` r
.OpenFile(x, ...)

.FileOpen(x, ...)

# Default S3 method
.OpenFile(x, force = FALSE, ...)

# S3 method for class 'data.frame'
.OpenFile(x, ...)

# S3 method for class 'matrix'
.OpenFile(x, ...)
```

## Arguments

- x:

  A object. If an existing file path, runs with
  [`xopen::xopen`](https://r-lib.github.io/xopen/reference/xopen.html).

- ...:

  Not used

- force:

  If `TRUE` ignores potential file path in `x`

## Value

The path to the open file
