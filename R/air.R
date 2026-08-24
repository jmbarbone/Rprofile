#' Run air
#'
#' Wrapper for calling `air`
#'
#' @param cmd The command to run (not the COMMAND option for `air help
#'   <COMMAND>`)
#' @param ... Additional arguments to pass to the command.
#' @export
#' @examples
#' \dontrun{
#' .Air("format", paths = "R", check = TRUE, log_level = "trace")
#' }
.Air <- function(cmd = c("format", "language-server", "help"), ...) {
  require_namespace("fs")
  waldo <- available_namespace("waldo")
  cmd <- air_command(cmd)
  opts <- air_options(cmd, ...)
  air <- normalizePath(Sys.which("air"), "/", mustWork = TRUE)
  if (cmd == "format") {
    n <- length(opts$args)
    if (
      waldo &&
        all(
          c("--check", "--version", "--help") %notin% c(opts$globals, opts$args)
        )
    ) {
      path <- opts$args[n]
      old <- lapply(
        list.files(path, include.dirs = FALSE, recursive = TRUE),
        readLines
      )
      on.exit({
        new <- lapply(
          list.files(path, include.dirs = FALSE, recursive = TRUE),
          readLines
        )
        print(with_waldo::compare(old, new))
      })
    }
    opts$args[n] <- shQuote(opts$args[n], "sh")
  }
  cat(
    crayon_silver(air),
    crayon_magenta(opts$globals),
    crayon_cyan(opts$command),
    crayon_blue(opts$args),
    "\n"
  )
  system2(air, unlist(opts))
}


air_command <- function(x = c("format", "language-server", "help")) {
  match_arg(x)
}

air_options <- function(cmd, ...) {
  opts <- switch(
    cmd,
    format = list(
      paths = ".",
      check = FALSE,
      help = FALSE
    ),
    `language-server` = list(help = FALSE),
    help = list(command = "help")
  )

  # globals
  opts <- c(
    opts,
    list(
      version = FALSE,
      log_level = "warn",
      no_color = as.integer(Sys.getenv("NO_COLOR", "0")) != 0L
    )
  )

  if (...length() > 0L) {
    if (!all(nzchar(...names()))) {
      stop(errorCondition(
        "All arguments must be named",
        class = "input_error"
      ))
    }

    updates <- list(...)
    updates <- updates[match_arg(
      names(updates),
      names(opts),
      multiple = TRUE,
      partial = FALSE
    )]
    opts[names(updates)] <- updates
  }

  list(
    globals = c(
      if (opts$version) "--version",
      "--log-level",
      match_arg(
        opts$log_level,
        c("error", "warn", "info", "debug", "trace")
      ),
      if (opts$no_color) "--no-color"
    ),
    command = cmd,
    args = switch(
      cmd,
      format = c(
        if (opts$check) "--check",
        if (opts$help) "--help",
        normalizePath(opts$paths, "/", mustWork = TRUE)
      ),
      `language-server` = c(if (opts$help) "--help"),
      help = air_command(opts$command)
    )
  )
}
