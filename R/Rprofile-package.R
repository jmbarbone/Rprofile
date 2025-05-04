#' @keywords internal
#' @importFrom fuj %||% %out% %colons% %wo%
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL

rprofile <- new.env()
local(envir = rprofile, {
  options <- new.env()
})
lockEnvironment(rprofile)

#' Jordan's Rprofile options
#'
#' @export
.RprofileJordan <- function() {
  .libPaths(c(
    .libPaths(),
    Sys.getenv("R_LIBS_PAK", "~/R/pak-library"),
    Sys.getenv("R_LIBS_SCRIBE", "~/R/scribe-library")
  ))

  .AttachDevtools()
  .AddAttachedPackagesToDefaultPackages()
  .GitBranchPrompt()
  .GlobalHandle()

  if (interactive()) {
    .UtilMessage("source_rprofile")
    .NiceMessage()
    .Todos(.quiet = FALSE, .space = TRUE)
    .CheckCranStatus()
    .Search()

    if (requireNamespace("shiny", quietly = TRUE)) {
      shiny::devmode()
    }
  }

  jordan <-
    tolower(Sys.getenv("USER", Sys.getenv("USERNAME"))) %in%
    c("jordan", "jbarbone", "jmbarbone", "jmbar")

  # Loads devtools and usethis
  local({
    opts <- list(
      tidyverse.quiet = TRUE,
      testthat.progress.max_fails = 100
    )

    if (jordan) {
      opts <- c(
        opts,
        list(
          devtools.name = "Jordan Mark Barbone",
          mark.author = list(
            given = "Jordan Mark",
            family = "Barbone",
            role = c("aut", "cph", "cre"),
            email = "jmbarbone@gmail.com",
            comment = c(ORCID = "0000-0001-9788-3628")
          ),
          usethis.description = list(
            `Authors@R` = 'person(
                          "Jordan Mark", "Barbone",
                          email = "jmbarbone@gmail.com",
                          role = c("aut", "cph", "cre"),
                          comment = c(ORCID = "0000-0001-9788-3628")
                        )',
            License = "MIT + file LICENSE",
            Language = "en-US"
          )
        )
      )
    }

    options(opts)
  })
}
