# This script is intentionally left blank

# Loads devtools and usethis

if (isFALSE(requireNamespace("devtools", quietly = TRUE))) {
  cat(".Rprofile: Installing devtools\n")
  try(utils::install.packages("devtools", repos = "https://cran.rstudio.com/", dependencies = TRUE))
}

try(suppressPackageStartupMessages(library("devtools", character.only = TRUE)))
op <- options()
options(warn = -1)
try(Rprofile::.GitBranchPrompt(), silent = TRUE)
options(op)
