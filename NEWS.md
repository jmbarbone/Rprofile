# Rprofile (development version)

## New features

* `.ReadClip()` added to read clipboard contents [#31]
* `.GithubRelease()` added to create a GitHub (pre)release [#29]
* `.Rprofile()` gains a `path` argument (with defaults) for identifying an `.Rprofile` location [#23]
* `.FindRprofile()` added to find your `.Rprofile` file; used within `.Rprofile()` [#23]
* Adds `.LintFile()` for selecting individual files to `lint` (defaults to currently opened file) [#21]
* Adds `.GitPrepareCommitMsg()` to copy one of two templates to `.git/hook/prepare-commit-msg` [#10]
* Adds `.OpenFile()` to open a file path or an object inside a file [#6]
* `.Rprofile(TRUE)` should work again with correction to internal `sf()`
* `.GitBranchPrompt()` has been simplified
* A new `..Rprofile` environment will be created on start-up as a copy of an internal package environment
* `@jmbarbone`'s preferred settings are now included as `.RprofileJordan()`, now a single command I can run in my `.Rprofile`
* `.CheckCranStatus()` has simplified output when `{cli}` is available; linked included to packages [#8]
* packing `lint`ing now included
* `.CheckCranStatus()` specifically sets temporary file for check status results
* `.CheckCranStatus()` outputs corrected
* `.GlobalHandle()` added to call `rlang::global_handle()`; added into `.RprofileJordan()`
* `.FileOpen()` now normalizes a path for a file before attempting to open
* `.OpenFile()` added as an alias for `.FileOpen()`
* `.RprofileJordan()` checks for additional library paths from envvars `R_LIBS_PAK` and `R_LIBS_SCRIBE`
* `.GithubRelease()` now prompts for both `publish` and `pre-release` params when they are not set
* `.NewsUrls()` paths corrected and no longer error in error
* `{fuj}` is now imported
* `.Pak()` added as a wrapper for `pak::pak()`
* `.UsePackageLibrary()` appends a new path to the library path based on the directory of the package

## Fixes

* `.Rprofile()` now uses `fs::path_expand_r()` to resolve tilde expansions, e.g., with `"~/.Rprofile"` [#23]
* Improves checking for `R_PROFILE` envvar
* `.CheckCranStatus()` now (again?) exits quietly when an email is not found

## Enhancements

* `.NewsUrls()` now has prettier print for differences; URLs detected are highlighted with `{crayon}` and only the changed lines (with line numbers) are printed
* Improvements with package checking
* Prompts via `utils::menu()` cleaned up

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
