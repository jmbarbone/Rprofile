#' Use GitHub Action
#'
#' @param x,repo,name,ref Name/location of the action.  You can use a format
#'   such as `"<<repo>|<owner>/<repo>>/<[examples/]/<path>>@<ref>"`.  This
#'   function will automatically check an `examples/` subdirectory in the
#'   repository.
#' @param ask Checks if existing files should be overwritten
#' @export
#' @examples
#' \dontrun{
#' .UseGithubAction("jmbarbone/actions/r-check-version")
#' .UseGithubAction("r-lib/actions/lint@v2")
#' }
#'
.UseGithubAction <- function(
  x,
  repo = NULL,
  name = NULL,
  ref = NULL,
  ask = interactive()
) {
  get_repo <- function(x) {
    paste0(strsplit(x, "/")[[1L]][1:2], collapse = "/")
  }

  get_name <- function(x) {
    name <- collapse(strsplit(x, "/")[[1L]][-(1:2)], sep = "/")
    sub("@.*$", "", name)
  }

  get_ref <- function(x, repo) {
    if (grepl("@", x, fixed = TRUE)) {
      return(sub(".*@", "", x))
    }

    require_namespace("gh")
    reset_namespaces({
      info <- gh::gh(sprintf("GET https://api.github.com/repos/%s", repo))
      resp <- gh::gh(sprintf("/repos/%s/releases", repo))

      if (length(resp) == 0L) {
        return(info$default_branch)
      }

      releases <- fuj::toss(
        fuj::vap_chr(resp, "tag_name"),
        fuj::vap_lgl(resp, "prerelease"),
        na = "drop"
      )

      fuj::hold(
        releases,
        which.max(as.numeric_version(sub("v", "", releases, fixed = TRUE)))
      )
    })
  }

  read_url <- function(repo, name, ref) {
    url <- sprintf(
      "https://raw.githubusercontent.com/%s/%s/%s",
      repo,
      ref,
      name
    )
    message("trying ", url)
    suppressWarnings(readLines(base::url(url)))
  }

  repo <- repo %||% get_repo(x)
  name <- name %||% get_name(x)
  ref <- ref %||% get_ref(x, repo)

  names <- c(
    if (!grepl("examples", name, fixed = TRUE)) {
      paste0("examples/", name, c(".yaml", ".yml"))
    },
    paste0(name, c(".yaml", ".yml")),
    NULL
  )

  action <- NULL
  for (nm in names) {
    tryCatch(
      {
        action <- read_url(repo, nm, ref)
        break
      },
      simpleError = invisible
    )
  }
  if (is.null(action)) {
    stop(errorCondition(
      sprintf(
        "Could not find GitHub Action '%s' in repository '%s' with ref '%s'",
        name,
        repo,
        ref
      ),
      class = "input_error"
    ))
  }

  path <- file.path(".github/workflows", basename(nm))
  path <- normalizePath(path, mustWork = FALSE)

  if (ask && file.exists(path)) {
    save <- yes_no("Would you like to override ", path, "?")
  } else {
    save <- TRUE
  }

  if (save) {
    writeLines(action, path)
    cat("Success!\n")
    invisible(TRUE)
  } else {
    cat("Aborted\n")
    invisible(FALSE)
  }
}

#' @export
#' @rdname dot-UseGithubAction
.UseGitHubAction <- .UseGithubAction
