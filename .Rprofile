local({
  r_libs_rprofile <- Sys.getenv("R_LIBS_RPROFILE")
  if (!nzchar(r_libs_rprofile)) {
    warning(warningCondition(
      "R_LIBS_RPROFILE is not set, using default '~/R/rprofile-library'",
      class = ".Rprofile_warning"
    ))
    r_libs_rprofile <- "~/R/rprofile-library"
  }
  dir.create(r_libs_rprofile, showWarnings = FALSE, recursive = TRUE)
  .libPaths(c(r_libs_rprofile, .libPaths()))
  Sys.setenv(R_LIBS_RPROFILE = r_libs_rprofile)
})

suppressPackageStartupMessages({
  try(require(usethis))
  try(require(devtools))
})

if (
  isTRUE(requireNamespace(
    "Rprofile",
    lib = Sys.getenv("R_LIBS_RPROFILE", .libPaths()),
    quietly = TRUE
  ))
) {
  local({
    safely <- function(expr) tryCatch(expr, error = \(e) invisible())
    safely(Rprofile::.AttachDevtools())
    safely(Rprofile::.GitBranchPrompt())
    safely(Rprofile::.UsePackageLibrary())
    safely(unloadNamespace("Rprofile"))
  })
}
