#' @keywords internal
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

# we will prioritize this library path for functions inside .Rprofile
.Library.Rprofile <- Sys.getenv("R_LIBS_RPROFILE", "~/rprofile-library")

#' Jordan's Rprofile options
#'
#' @export
.RprofileJordan <- function() {
  .libPaths(c(
    .libPaths(),
    Sys.getenv("R_LIBS_PAK", "~/R/pak-library"),
    Sys.getenv("R_LIBS_SCRIBE", "~/R/scribe-library"),
    .Library.Rprofile
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

    conflictRules(
      "fuj",
      mask.ok = list(
        testthat = "not"
      )
    )
    conflictRules(
      "cnd",
      mask.ok = list(
        fuj = c(
          "value_error",
          "class_error",
          "type_error",
          "input_error",
          "use_error",
          "duplicate_error",
          "defunct_error",
          "internal_error"
        )
      )
    )

    options(opts)
  })
}

.onAttach <- function(libname, pkgname) {
  get("assign", baseenv())("..Rprofile", rprofile, envir = globalenv())
}

.onDetach <- function(libname, pkgname) {
  if (exists("..Rprofile", envir = globalenv())) {
    rm("..Rprofile", envir = globalenv())
  }
}

.onLoad <- function(libname, pkgname) {
  r_libs_profile <- Sys.getenv("R_LIBS_RPROFILE")
  r_libs_profile <- normalizePath(r_libs_profile, "/", FALSE)
  if (!nzchar(r_libs_profile)) {
    cat(
      "Warning: R_LIBS_RPROFILE is not set. Please set it to a valid path.\n",
      "This may cause unexpected behavior.\n"
    )
    return()
  }

  if (!isTRUE(dir.exists(r_libs_profile))) {
    try(dir.create(r_libs_profile, recursive = TRUE, showWarnings = FALSE))
  }

  path <- getNamespaceInfo("Rprofile", "path")
  path <- normalizePath(path, winslash = "/", mustWork = FALSE)
  if (match(path, c(getwd(), r_libs_profile), 0L) == 0L) {
    cat(
      "Warning: R_LIBS_RPROFILE is set to a different path than the Rprofile package.\n",
      "R_LIBS_RPROFILE: ",
      r_libs_profile,
      "\n",
      "Rprofile path: ",
      path,
      "\n",
      "This may cause unexpected behavior.\n"
    )
  }
}
