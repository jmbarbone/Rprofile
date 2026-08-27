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
