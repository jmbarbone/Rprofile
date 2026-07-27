# Use GitHub Action

Use GitHub Action

## Usage

``` r
.UseGithubAction(x, repo = NULL, name = NULL, ref = NULL, ask = interactive())

.UseGitHubAction(x, repo = NULL, name = NULL, ref = NULL, ask = interactive())
```

## Arguments

- x, repo, name, ref:

  Name/location of the action. You can use a format such as
  `"<<repo>|<owner>/<repo>>/<[examples/]/<path>>@<ref>"`. This function
  will automatically check an `examples/` subdirectory in the
  repository.

- ask:

  Checks if existing files should be overwritten

## Examples

``` r
if (FALSE) { # \dontrun{
.UseGithubAction("jmbarbone/actions/r-check-version")
.UseGithubAction("r-lib/actions/lint@v2")
} # }
```
