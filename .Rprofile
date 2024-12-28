# This script is intentionally left blank

# Loads devtools and usethis

if (isTRUE(requireNamespace("Rprofile", quietly = TRUE))) {
  local({
    ignore <- function(...) invisible()
    tryCatch(Rprofile::.AttachDevtools(), error = ignore)
    tryCatch(Rprofile::.GitBranchPrompt(), error = ignore)
    tryCatch(Rprofile::.UsePackageLibrary(), error = ignore)
  })
  tryCatch(unloadNamespace("Rprofile"), error = \(e) invisible())
}
