# Finds where tag is in file and removes the line and the line after Assumes that the 'tag' is from this package and starts with '@jordan\_' setting "tag" to NULL will remove any instances

Finds where tag is in file and removes the line and the line after
Assumes that the 'tag' is from this package and starts with '@jordan\_'
setting "tag" to NULL will remove any instances

## Usage

``` r
remove_tag_and_save(file, tag, warn = TRUE)
```

## Arguments

- file:

  A file path

- tag:

  A character tag

- warn:

  if `FALSE` will not produce a warning message
