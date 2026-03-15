# Add URLs to NEWS

Include links to github on `NEWS.md`

## Usage

``` r
.NewsUrls(path = ".", ask = interactive(), url = get_desc_url(path))
```

## Arguments

- path:

  The path to your package

- ask:

  Prompts updating `NEWS.md`

- url:

  Optional URL to set for bug reports

## Value

Nothing, called for its side effects

## Details

URLs are detected for GitHub issue. For example, a line with "Fixes bug
\[#123\]" will append the URL for the issue number 123. The repository
is picked up from the `DESCRIPTION` file.
