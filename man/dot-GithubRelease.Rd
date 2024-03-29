% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/github-release.R
\name{.GithubRelease}
\alias{.GithubRelease}
\title{Create a \strong{GitHub} Release}
\usage{
.GithubRelease(publish = NULL, prerelease = FALSE)
}
\arguments{
\item{publish}{Whether to publish the release or keep as a draft.  Default is
\code{FALSE}.}

\item{prerelease}{Whether to create prerelease.  Default is \code{FALSE}.}
}
\description{
Wrapper for \code{usethis::use_github_release()}.
}
\details{
When \code{prerelease} is \code{TRUE}, a facsimile of
\code{usethis::use_github_release()} is employed to create a prerelease.  This
assumes ...
\itemize{
\item the package is hosted on \strong{GitHub}
\item the remote is named \strong{origin}d
\item the branch is named \strong{main}
\item the package has a \strong{DESCRIPTION} file which contains an appropriate
\code{Package} name and \code{Version}
\item you want to use the \code{generate_release_notes} feature of the
\href{https://docs.github.com/en/rest/releases/releases?apiVersion=2022-11-28#create-a-release}{GitHub API}
}
}
