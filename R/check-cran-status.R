#' Check Cran Status
#'
#' A wrapper
#'
#' @param email The email address to query CRAN
#' @seealso [dang::checkCRANStatus()]
#' @export
.CheckCranStatus <- function(email = NULL) {
  if (!requireNamespace("dang", quietly = TRUE)) {
    return(invisible())
  }

  if (is.null(email) && !length(email)) {
   email <- .try(get_description_emails())
   if (inherits(email, "error")) {
     return(invisible())
   }
  }

  cat("Checking CRAN status\n")
  success <- FALSE
  for (e in email) {
    if (success) cat("\n")
    cat("checking for", crayon_blue(e))
    # shhhh
    res <- .try(utils::capture.output(dang::checkCRANStatus(e)))
    if (!inherits(res, "error")) {
      show_table()
      success <- TRUE
    } else {
      cat(crayon_silver(" ... nope, not found\n"))
      success <- FALSE
    }
  }

  return(invisible(NULL))
}

show_table <- function() {
  res <- get_recent_cran_check()
  time <- crayon_yellow(res[[1]])
  tab <- res[[2]]

  cat("\n")
  writeLines(time)
  print_cran_status(tab)
}

get_recent_cran_check <- function() {
  files <- list.files(tempdir(), "^cran-status.*.rds$", full.names = TRUE)
  res <- files[which.max(file.mtime(files))]
  readRDS(res)
}

print_cran_status <- function(x) {
  if (!use_color()) {
    return(print(x))
  }

  xx <- x
  x <- as.data.frame(x)
  cols <- c("PACKAGE", "ERROR", "WARN", "NOTE", "OK")
  m <- match(cols, toupper(colnames(x)), 0L)
  names(m) <- cols
  w <- which(m > 0L)
  mc <- m[w]

  # I got lazy...
  if (all(m == 0L)) {
    return(print(x))
  }

  # now get them again without the formatting
  cn <- crayon_strip(colnames(x))

  if (isTRUE(mc["ERROR"] > 0L)) {
    x[[mc["ERROR"]]] <- crayon_red(x[[m["ERROR"]]])
  }

  if (isTRUE(mc["WARN"] > 0L)) {
    x[[mc["WARN"]]] <- crayon_magenta(x[[m["WARN"]]])
  }

  if (isTRUE(mc["OK"] > 0L)) {
    x[[mc["OK"]]] <- crayon_green(x[[m["OK"]]])
  }

  if (requireNamespace("cli", quietly = TRUE)) {
    apply(x, 1L, function(row) {
      cli::cli_text(
        sprintf(
          # nolint next: line_length_linter.
          "{.href [%s](https://cloud.r-project.org/web/packages/%s/index.html)} ",
          row[1L],
          row[1L]
        ),
        paste0(row[-1L], collapse = " ")
      )
    })
    return(invisible(xx))
  }

  colnames(x)[mc] <- c(
    "PACKAGE",
    crayon_red("ERROR"),
    crayon_magenta("WARN"),
    crayon_blue("NOTE"),
    crayon_green("OK")
  )[w]

  if (mc["PACKAGE"] > 0L) {
    i <- mc["PACKAGE"]
    ns <- max(nchar(c(cn[i], x[[i]]))) + 1L
    x[[i]] <- format(x[[i]], width = ns)
    colnames(x)[i] <- format(colnames(x)[i], width = ns)
  }

  for (i in mc[-1]) {
    ok <- which(!is.na(x[[i]]) & x[[i]] != "")
    ns <- nchar(trimws(c(cn[i], x[[i]][ok])))
    max <- max(max(ns) + 1L, 3L)
    numbs <- format(as.integer(x[[i]][ok]), width = max)
    x[[i]] <- ""
    x[[i]][ok] <- numbs
    x[[i]] <- format(x[[i]], width = max)
    colnames(x)[i] <- paste0(strrep(" ", max - ns[1L]), colnames(x)[i])
  }

  cat(colnames(x), "\n")
  apply(x, 1L, function(i) cat(i, "\n"))
  invisible(xx)
}

get_description_emails <- function() {
  pkg <- basename(normalizePath("."))

  authors <- suppressWarnings(utils::packageDescription(pkg))

  if (length(authors) == 1L && is.na(authors)) {
    stop("Package `", pkg, "` not found in installed", call. = FALSE)
  }

  authors <- authors$Authors # partial matching for Authors@R

  if (any(grepl("person", authors))) {
    authors <- gsub("(?<!utils::)person", "utils::person", authors, perl = TRUE)
    requireNamespace("utils", quietly = TRUE)
  }

  authors <- eval(parse(text = trimws(authors)))
  authors <- unclass(authors)
  unlist(lapply(authors, `[[`, "email"), use.names = FALSE)
}
