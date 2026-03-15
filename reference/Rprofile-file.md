# Get .Rprofile

Get .Rprofile

## Usage

``` r
.Rprofile(update = overwrite, overwrite = FALSE, path = .FindRprofile())

.FindRprofile(quiet = FALSE)
```

## Arguments

- update:

  If `TRUE` will copy the .Rprofile from the Rprofile package (defaults
  to the value of `overwrite`)

- overwrite:

  If `TRUE` and `update = TRUE` will overwrite .Rprofile if it exists;
  ignored if `update` is not `TRUE`

- path:

  The file location of your `.Rprofile`

- quiet:

  If `TRUE` silences messages, otherwise provides information about the
  location of `.Rprofile`

## Value

- `.Rprofile()` The `.Rprofile()` path, invisibly

&nbsp;

- `.FindRprofile()` (hopefully) a path to your `.Rprofile`

## See also

Other Rprofile:
[`.AddRprofileOptions()`](https://jmbarbone.github.io/Rprofile/reference/dot-AddRprofileOptions.md),
[`.AttachDevtools()`](https://jmbarbone.github.io/Rprofile/reference/dot-AttachDevtools.md),
[`.NiceMessage()`](https://jmbarbone.github.io/Rprofile/reference/dot-NiceMessage.md),
[`.Search()`](https://jmbarbone.github.io/Rprofile/reference/dot-Search.md),
[`.UtilMessage()`](https://jmbarbone.github.io/Rprofile/reference/dot-UtilMessage.md),
[`attached_packages`](https://jmbarbone.github.io/Rprofile/reference/attached_packages.md)
