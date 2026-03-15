# Git prepare commit message

Copies one of two git message preparation templates

## Usage

``` r
.GitPrepareCommitMsg(
  path = ".",
  method = c(list(`github-end` = c("github", "github-end"), `jira-start` = c("jira",
    "jira-start"), "github-start", "jira-end")),
  overwrite = FALSE
)
```

## Arguments

- path:

  The path directory of your package (with a `.git` folder inside)

- method:

  One of the following (see details for more info): `github`, `jira`,
  `github-start`, `github-end`, `jira-start`, `jira-end`. The `github`
  versions looks for numeric starts to a branch name, and then either
  appends the branch number to the beginning of the message with an
  octothorp (e.g., 123-branch appends "#123 ") or at the end, wrapped in
  parenthesis. The `jira` version looks for the alphanumeric code value
  of a ticket and appends that with square brackets (e.g., ABC-123
  appends "\[ABC-123\] ") to the start or the end. Appending to the
  *end* is the default functionality got `github` but appending to the
  *start* is the default for `jira`.

- overwrite:

  If `TRUE`, overwrites the `.git/hooks/prepare-commit-msg` file, if it
  exists (passed to
  [`fs::file_copy`](https://fs.r-lib.org/reference/copy.html))
