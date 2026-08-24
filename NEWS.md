# Rprofile (development version)

## New features

* `.ReadClip()` added to read clipboard contents [#31]
* `.GithubRelease()` added to create a GitHub (pre)release [#29], [#41]
* `.FindRprofile()` added to find your `.Rprofile` file; used within `.Rprofile()` [#23]
* `.LintFile()` added for selecting individual files to `lint` (defaults to currently opened file) [#21]
* `.GitPrepareCommitMsg()` added to copy one of two templates to `.git/hook/prepare-commit-msg` [#10]
* `.OpenFile()` added to open a file path or an object inside a file [#6]
* `.GlobalHandle()` added to call `rlang::global_handle()`; added into `.RprofileJordan()`
* `.OpenFile()` added as an alias for `.FileOpen()`
* `.GitHubRelease()` added as an alias for `.GithubRelease()`
* `.Pak()` added as a wrapper for `pak::pak()`
* `.Air()` added to call `air format .`
* `.UseGithubAction()` (alias `.UseGitHubAction()`) added to copy a GitHub Action workflow template to `.github/workflows/`
* `.RemoveGlobalConflicts()` added to remove global conflicts

## Fixes

* Improves checking for `R_PROFILE` envvar
* `.Rprofile(TRUE)` should work again with correction to internal `sf()`
* `.CheckCranStatus()` has simplified output when `{cli}` is available; linked included to packages [#8]
* `.CheckCranStatus()` specifically sets temporary file for check status results
* `.CheckCranStatus()` outputs corrected
* `.Rprofile()` now uses `fs::path_expand_r()` to resolve tilde expansions, e.g., with `"~/.Rprofile"` [#23]
* `.CheckCranStatus()` now (again?) exits quietly when an email is not found
* `.NewsUrls()` paths corrected and no longer errors

## Enhancements

* `.GithubRelease()` now prompts for both `publish` and `pre-release` params when they are not set
* `.RprofileJordan()` checks for additional library paths from envvars `R_LIBS_PAK` and `R_LIBS_SCRIBE`
* `.UsePackageLibrary()` appends a new path to the library path based on the directory of the package
* `.Search(pattern)` now allows for pattern matching [#38]
* `.Rprofile()` gains a `path` argument (with defaults) for identifying an `.Rprofile` location [#23]
* `.GitBranchPrompt()` now uses a function and doesn't require manual runs to update branch [#43]
* `.FileOpen()` now normalizes a path for a file before attempting to open
* `.GitBranchPrompt()` has been simplified
* `.NewsUrls()` now has prettier print for differences; URLs detected are highlighted with `{crayon}` and only the changed lines (with line numbers) are printed
* Improvements with package checking
* Prompts via `utils::menu()` cleaned up
* Additional namespaces will be unloaded if they not already loaded

## Internal

* `@jmbarbone`'s preferred settings are now included as `.RprofileJordan()`, now a single command I can run in my `.Rprofile`
* package `lint`ing now included
* A new `..Rprofile` environment will be created on start-up as a copy of an internal package environment
* `{fuj}` is now imported
* `{magrittr}` removed as an import 

# Rprofile 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.
* Initial exported general utilities
  * `.CharacterIndex()` to show character index values of strings
  * `.CheckCranStatus()` to show current CRAN status from emails listed in `DESCRIPTION`
  * `.Todos()`, `.TodosHere()`, `.Fixmes()`, `.FixmesHere()`,  to find `TODO` and `FIXME` notes in your R files.  The `*Here()` alternatives detect your current document in **RStudio**
  * `.GitBranchPrompt()` to change the prompt to your git branch
  * `.NiceMessage()` to print a nice message
  * `.OpenPackageUrl()` to open URLs found in `DESCRIPTION`
  * `.Restart()`, `.Reload()` to restart your **RStudio** session; or also remove objects
  * `.RemoveAll()` to remove all objects from your environment
  * `.RemoveAttachedPackages()` to detach packages loaded during your session
  * `.ResetOptions()` to reset options in your current session
  * `.Search()` to print out `search()` a bit nicer
* Initial exported `.Rprofile` utilities
  * `.AddAttachedPackagesToDefaultPackages()`
  * `.AddRprofileOptions()`
  * `.AttachDevtools()`
  * `.SendAttachedPackagesToREnviron()`
  * `.UtilMessage()`
