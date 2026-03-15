# Create a **GitHub** Release

Wrapper for
[`usethis::use_github_release()`](https://usethis.r-lib.org/reference/use_github_release.html).

## Usage

``` r
.GithubRelease(publish = NULL, prerelease = NULL)
```

## Arguments

- publish, prerelease:

  Whether this release should be published and if it should be tagged as
  a **prerelease**. When
  [`missing()`](https://rdrr.io/r/base/missing.html) will prompt during
  an [`interactive()`](https://rdrr.io/r/base/interactive.html) session,
  otherwise defaults to `FALSE`

## Details

When `prerelease` is `TRUE`, a facsimile of
[`usethis::use_github_release()`](https://usethis.r-lib.org/reference/use_github_release.html)
is employed to create a prerelease. This assumes ...

- the package is hosted on **GitHub**

- the remote is named **origin**

- the branch is named **main**

- the package has a **DESCRIPTION** file which contains an appropriate
  `Package` name and `Version`

- you want to use the `generate_release_notes` feature of the [GitHub
  API](https://docs.github.com/en/rest/releases/releases?apiVersion=2022-11-28#create-a-release)
