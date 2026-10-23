#' Check R package
#'
#' @export
.Check <- function() {
  require_namespace("rcmdcheck")
  rproj <- list.files(pattern = "*\\.Rproj$")
  lines <- strsplit(readLines(rproj), ":", fixed = TRUE)
  lines <- lines[lengths(lines) > 0L]
  opts <- do.call(
    base::c,
    lapply(lines, \(x) structure(list(x[2L]), names = x[1L]))
  )

  args <- scan(
    text = opts[["PackageInstallArgs"]] %||% character(),
    what = character()
  )

  build_args <- scan(
    text = opts[["PackageInstallBuildArgs"]] %||% character(),
    what = character()
  )

  rcmdcheck::rcmdcheck(
    path = ".",
    args = args,
    build_args = build_args
  )
}
