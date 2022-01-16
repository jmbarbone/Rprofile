
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Rprofile

<!-- badges: start -->

[![R-CMD-check](https://github.com/jmbarbone/Rprofile/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jmbarbone/Rprofile/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of Rprofile is to provide simple, non-intrusive functions for
development that are not intended to be used in final packages. These
function to assist during the development process.

## Installation

You can install the developmental version of Rprofile with:

``` r
remotes::install_github("jmbarbone/Rprofile")
```

## Example

``` r
library(Rprofile)
.NiceMessage()
#> You are ultimate!
.CharacterIndex("your string here")
#> [[1]]
#>  y  o  u  r     s  t  r  i  n  g     h  e  r  e 
#>  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
```

``` r
.RemoveAll()        # removes all objects
.Reload()           # removes objects and restart Rstudio session
.ResetOptions()     # resets options
.GitBranchPrompt()  # shows git branch
.Todos(), .Fixmes() # shows comments marked as TODO or FIXME
```
