# Manage attached packages

Clears out attached packages and properly loads

## Usage

``` r
.SendAttachedPackagesToREnviron()

.RemoveAttachedPackages(attached = search())

.AddAttachedPackagesToDefaultPackages()
```

## Arguments

- attached:

  A character vector of packages, defaulting to
  [`search()`](https://rdrr.io/r/base/search.html)

## See also

Other Rprofile:
[`.AddRprofileOptions()`](https://jmbarbone.github.io/Rprofile/reference/dot-AddRprofileOptions.md),
[`.AttachDevtools()`](https://jmbarbone.github.io/Rprofile/reference/dot-AttachDevtools.md),
[`.NiceMessage()`](https://jmbarbone.github.io/Rprofile/reference/dot-NiceMessage.md),
[`.Search()`](https://jmbarbone.github.io/Rprofile/reference/dot-Search.md),
[`.UtilMessage()`](https://jmbarbone.github.io/Rprofile/reference/dot-UtilMessage.md),
[`Rprofile-file`](https://jmbarbone.github.io/Rprofile/reference/Rprofile-file.md)
