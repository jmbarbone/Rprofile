# This script is intentionally left blank

# Loads devtools and usethis

if (isTRUE(requireNamespace("Rprofile", quietly = TRUE))) {
  local({
    safely <- function(expr) tryCatch(expr, error = \(e) invisible)
    safely(Rprofile::.AttachDevtools())
    safely(Rprofile::.GitBranchPrompt())
    safely(Rprofile::.UsePackageLibrary())
    safely(unloadNamespace("Rprofile"))
  })
}
