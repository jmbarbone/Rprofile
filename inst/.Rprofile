
# Rstudio/.Rprofile -------------------------------------------------------
# Jordan's personal .Rprofile
# Rprofile::.Rprofile(update = TRUE)

if (isTRUE(requireNamespace("Rprofile", quietly = TRUE))) {
  while ("package:Rprofile" %in% search()) {
    detach("package:Rprofile")
  }

  library(Rprofile)

  # Loads devtools and usethis
  suppressPackageStartupMessages(library(devtools))

  .AddRprofileOptions(
    # crayon.enabled = interactive(),
    tidyverse.quiet = TRUE,
    devtools.name = "Jordan Mark Barbone",
    testthat.progress.max_fails = 100,

    # For mark::use_author()
    mark.author = list(
      given = "Jordan Mark",
      family = "Barbone",
      role = c("aut", "cph", "cre"),
      email = "jmbarbone@gmail.com",
      comment = c(ORCID = "0000-0001-9788-3628")
    ),

    usethis.description = list(
      `Authors@R` = 'person("Jordan Mark", "Barbone", email = "jmbarbone@gmail.com",
                          role = c("aut", "cph", "cre"),
                          comment = c(ORCID = "0000-0001-9788-3628"))',
      License = "MIT + file LICENSE",
      Language =  "en-US"
    )
  )

  .AddAttachedPackagesToDefaultPackages()
  .GitBranchPrompt()

  if (interactive()) {
    .AddRprofileOptions(crayon.enabled = TRUE)
    cat(crayon::cyan("Sourcing Rprofile/.Rprofile...\n"))
    .NiceMessage()
    .Todos(.quiet = FALSE, .space = TRUE)
    .AddRprofileOptions(crayon.enabled = NULL)
    .CheckCranStatus()
  }
}
