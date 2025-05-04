require(usethis)
require(devtools)

.libPaths(c(.libPaths(), "~/R/pak-library", "~/R/scribe-library"))

if (require(Rprofile, quietly = TRUE)) {
  .RprofileJordan()
}
