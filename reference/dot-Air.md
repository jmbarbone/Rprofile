# Run air

Wrapper for calling `air`

## Usage

``` r
.Air(cmd = c("format", "language-server", "help"), ...)
```

## Arguments

- cmd:

  The command to run (not the COMMAND option for `air help <COMMAND>`)

- ...:

  Additional arguments to pass to the command.

## Examples

``` r
if (FALSE) { # \dontrun{
.Air("format", paths = "R", check = TRUE, log_level = "trace")
} # }
```
