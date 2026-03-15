# Character index

Splits a vector into each character and shows the index

## Usage

``` r
.CharacterIndex(x = NULL)
```

## Arguments

- x:

  A character vector

## References

Inspired by:
https://www.r-bloggers.com/2020/12/little-helpers-character-index-counter/

## Examples

``` r
x <- c("Split this apart", "and count each character.")
.CharacterIndex(x)
#> [[1]]
#>  S  p  l  i  t     t  h  i  s     a  p  a  r  t 
#>  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 
#> 
#> [[2]]
#>  a  n  d     c  o  u  n  t     e  a  c  h     c  h  a  r  a  c  t  e  r  . 
#>  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 
#> 
```
