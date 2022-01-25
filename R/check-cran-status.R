#' Check Cran Status
#'
#' A wrapper
#'
#' @param email The email address to query CRAN
#' @seealso [dang::checkCRANStatus]
#' @export
.CheckCranStatus <- function(email = NULL) {
  # op <- options(warn = -1) # get rid of warnings for now
  # on.exit(options(op))

  if (!mark::package_available("dang")) {
    return(invisible())
  }

  if (is.null(email)) {
   email <- suppressWarnings(try(get_description_emails()))
   if (inherits(email, "try-error")) {
     return(invisible())
   }
  }

  success <- FALSE
  for (e in email) {
    if (success) cat("\n")
    cat("checking for", crayon_blue(e))
    # shhhh
    res <- suppressWarnings(
      try(utils::capture.output(dang::checkCRANStatus(e)), silent = TRUE)
    )
    if (!inherits(res, "try-error")) {
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
  files <- list.files(tempdir(), "^cran-status.*.rds$", full.names = TRUE)
  res <- files[which.max(file.mtime(files))]
  res <- readRDS(res)

  time <- crayon_yellow(res[[1]])
  tab <- res[[2]]

  cat("\n")
  writeLines(time)
  print_cran_status(tab)
}

print_cran_status <- function(x) {
  if (!use_color()) {
    return(print(x))
  }


  x <- as.data.frame(x)
  m <- match(c("PACKAGE", "ERROR", "WARN", "NOTE", "OK"), toupper(colnames(x)), 0L)

  # I got lazy...
  if (all(m == 0L)) {
    return(print(x))
  }

  colnames(x)[m]  <- c("PACKAGE", crayon_red("ERROR"), crayon_magenta("WARN"), crayon_blue("NOTE"), crayon_green("OK"))[m]
  cn <- crayon_strip(colnames(x))

  if (m[1] != 0) {
    ns <- max(nchar(c(cn[m[1]], x[[m[1]]])))
    x[[m[1]]] <- format(x[[m[1]]], width = ns)
    colnames(x)[m[1]] <- format(colnames(x)[m[1]], width = ns)
  }

  for (i in m[-1]) {
    if (i == 0) next
    ok <- !(is.na(x[[i]]) | x[[i]] == "")
    ns <- nchar(trimws(c(cn[i], x[[i]][ok])))
    max <- max(max(ns), 3)
    numbs <- format(as.integer(x[[i]][ok]), width = max)
    x[[i]] <- ""
    x[[i]][ok] <- numbs
    x[[i]] <- format(x[[i]], width = max)
    colnames(x)[i] <- paste0(strrep(" ", max - ns[1]), colnames(x)[i])
  }

  if (m[2] > 0) x[[m[2]]] <- crayon_red(x[[m[2]]])
  if (m[3] > 0) x[[m[3]]] <- crayon_magenta(x[[m[3]]])
  if (m[5] > 0) x[[m[5]]] <- crayon_green(x[[m[5]]])

  cat(colnames(x), "\n")
  apply(x, 1L, function(i) cat(i, "\n"))
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
