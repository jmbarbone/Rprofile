# This script is intentionally left blank

# Loads devtools and usethis

if (isTRUE(requireNamespace("devtools", quietly = TRUE))) {
  cat(".Rprofile: Loading devtools\n")
  suppressPackageStartupMessages(library("devtools", character.only = TRUE))
}

op <- options()
options(warn = -1)
try(Rprofile::.GitBranchPrompt(), silent = TRUE)
options(op)
