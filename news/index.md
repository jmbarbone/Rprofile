# Changelog

## Rprofile (development version)

### New features

- [`.ReadClip()`](https://jmbarbone.github.io/Rprofile/reference/dot-ReadClip.md)
  added to read clipboard contents \[#31\]
- [`.GithubRelease()`](https://jmbarbone.github.io/Rprofile/reference/dot-GithubRelease.md)
  added to create a GitHub (pre)release \[#29\], \[#41\]
- [`.Rprofile()`](https://jmbarbone.github.io/Rprofile/reference/Rprofile-file.md)
  gains a `path` argument (with defaults) for identifying an `.Rprofile`
  location \[#23\]
- [`.FindRprofile()`](https://jmbarbone.github.io/Rprofile/reference/Rprofile-file.md)
  added to find your `.Rprofile` file; used within
  [`.Rprofile()`](https://jmbarbone.github.io/Rprofile/reference/Rprofile-file.md)
  \[#23\]
- Adds
  [`.LintFile()`](https://jmbarbone.github.io/Rprofile/reference/dot-LintFile.md)
  for selecting individual files to `lint` (defaults to currently opened
  file) \[#21\]
- Adds
  [`.GitPrepareCommitMsg()`](https://jmbarbone.github.io/Rprofile/reference/dot-GitPrepareCommitMsg.md)
  to copy one of two templates to `.git/hook/prepare-commit-msg` \[#10\]
- Adds
  [`.OpenFile()`](https://jmbarbone.github.io/Rprofile/reference/OpenFile.md)
  to open a file path or an object inside a file \[#6\]
- `.Rprofile(TRUE)` should work again with correction to internal `sf()`
- [`.GitBranchPrompt()`](https://jmbarbone.github.io/Rprofile/reference/dot-GitBranchPrompt.md)
  has been simplified
- A new `..Rprofile` environment will be created on start-up as a copy
  of an internal package environment
- `@jmbarbone`’s preferred settings are now included as
  [`.RprofileJordan()`](https://jmbarbone.github.io/Rprofile/reference/dot-RprofileJordan.md),
  now a single command I can run in my `.Rprofile`
- [`.CheckCranStatus()`](https://jmbarbone.github.io/Rprofile/reference/dot-CheckCranStatus.md)
  has simplified output when [cli](https://cli.r-lib.org) is available;
  linked included to packages \[#8\]
- packing `lint`ing now included
- [`.CheckCranStatus()`](https://jmbarbone.github.io/Rprofile/reference/dot-CheckCranStatus.md)
  specifically sets temporary file for check status results
- [`.CheckCranStatus()`](https://jmbarbone.github.io/Rprofile/reference/dot-CheckCranStatus.md)
  outputs corrected
- [`.GlobalHandle()`](https://jmbarbone.github.io/Rprofile/reference/dot-GlobalHandle.md)
  added to call
  [`rlang::global_handle()`](https://rlang.r-lib.org/reference/global_handle.html);
  added into
  [`.RprofileJordan()`](https://jmbarbone.github.io/Rprofile/reference/dot-RprofileJordan.md)
- [`.FileOpen()`](https://jmbarbone.github.io/Rprofile/reference/OpenFile.md)
  now normalizes a path for a file before attempting to open
- [`.OpenFile()`](https://jmbarbone.github.io/Rprofile/reference/OpenFile.md)
  added as an alias for
  [`.FileOpen()`](https://jmbarbone.github.io/Rprofile/reference/OpenFile.md)
- [`.RprofileJordan()`](https://jmbarbone.github.io/Rprofile/reference/dot-RprofileJordan.md)
  checks for additional library paths from envvars `R_LIBS_PAK` and
  `R_LIBS_SCRIBE`
- [`.GithubRelease()`](https://jmbarbone.github.io/Rprofile/reference/dot-GithubRelease.md)
  now prompts for both `publish` and `pre-release` params when they are
  not set
- [`.NewsUrls()`](https://jmbarbone.github.io/Rprofile/reference/dot-NewsUrls.md)
  paths corrected and no longer error in error
- [fuj](https://jmbarbone.github.io/fuj/) is now imported
- [`.Pak()`](https://jmbarbone.github.io/Rprofile/reference/dot-Pak.md)
  added as a wrapper for
  [`pak::pak()`](https://pak.r-lib.org/reference/pak.html)
- [`.UsePackageLibrary()`](https://jmbarbone.github.io/Rprofile/reference/dot-UsePackageLibrary.md)
  appends a new path to the library path based on the directory of the
  package
- [`.RemoveGlobalConflicts()`](https://jmbarbone.github.io/Rprofile/reference/dot-RemoveGlobalConflicts.md)
  added to remove global conflicts
- `.Search(pattern)` now allows for pattern matching \[#38\]
- [magrittr](https://magrittr.tidyverse.org) removed as an import

### Fixes

- [`.Rprofile()`](https://jmbarbone.github.io/Rprofile/reference/Rprofile-file.md)
  now uses
  [`fs::path_expand_r()`](https://fs.r-lib.org/reference/path_expand.html)
  to resolve tilde expansions, e.g., with `"~/.Rprofile"` \[#23\]
- Improves checking for `R_PROFILE` envvar
- [`.CheckCranStatus()`](https://jmbarbone.github.io/Rprofile/reference/dot-CheckCranStatus.md)
  now (again?) exits quietly when an email is not found

### Enhancements

- [`.NewsUrls()`](https://jmbarbone.github.io/Rprofile/reference/dot-NewsUrls.md)
  now has prettier print for differences; URLs detected are highlighted
  with [crayon](https://r-lib.github.io/crayon/) and only the changed
  lines (with line numbers) are printed
- Improvements with package checking
- Prompts via [`utils::menu()`](https://rdrr.io/r/utils/menu.html)
  cleaned up

## Rprofile 0.0.0.9000

- Added a `NEWS.md` file to track changes to the package.
- Initial exported general utilities
  - [`.CharacterIndex()`](https://jmbarbone.github.io/Rprofile/reference/dot-CharacterIndex.md)
    to show character index values of strings
  - [`.CheckCranStatus()`](https://jmbarbone.github.io/Rprofile/reference/dot-CheckCranStatus.md)
    to show current CRAN status from emails listed in `DESCRIPTION`
  - [`.Todos()`](https://jmbarbone.github.io/Rprofile/reference/todos.md),
    [`.TodosHere()`](https://jmbarbone.github.io/Rprofile/reference/todos.md),
    [`.Fixmes()`](https://jmbarbone.github.io/Rprofile/reference/todos.md),
    [`.FixmesHere()`](https://jmbarbone.github.io/Rprofile/reference/todos.md),
    to find `TODO` and `FIXME` notes in your R files. The `*Here()`
    alternatives detect your current document in **RStudio**
  - [`.GitBranchPrompt()`](https://jmbarbone.github.io/Rprofile/reference/dot-GitBranchPrompt.md)
    to change the prompt to your git branch
  - [`.NiceMessage()`](https://jmbarbone.github.io/Rprofile/reference/dot-NiceMessage.md)
    to print a nice message
  - [`.OpenPackageUrl()`](https://jmbarbone.github.io/Rprofile/reference/dot-OpenPackageUrl.md)
    to open URLs found in `DESCRIPTION`
  - [`.Restart()`](https://jmbarbone.github.io/Rprofile/reference/Reload.md),
    [`.Reload()`](https://jmbarbone.github.io/Rprofile/reference/Reload.md)
    to restart your **RStudio** session; or also remove objects
  - [`.RemoveAll()`](https://jmbarbone.github.io/Rprofile/reference/dot-RemoveAll.md)
    to remove all objects from your environment
  - [`.RemoveAttachedPackages()`](https://jmbarbone.github.io/Rprofile/reference/attached_packages.md)
    to detach packages loaded during your session
  - [`.ResetOptions()`](https://jmbarbone.github.io/Rprofile/reference/dot-ResetOptions.md)
    to reset options in your current session
  - [`.Search()`](https://jmbarbone.github.io/Rprofile/reference/dot-Search.md)
    to print out [`search()`](https://rdrr.io/r/base/search.html) a bit
    nicer
- Initial exported `.Rprofile` utilities
  - [`.AddAttachedPackagesToDefaultPackages()`](https://jmbarbone.github.io/Rprofile/reference/attached_packages.md)
  - [`.AddRprofileOptions()`](https://jmbarbone.github.io/Rprofile/reference/dot-AddRprofileOptions.md)
  - [`.AttachDevtools()`](https://jmbarbone.github.io/Rprofile/reference/dot-AttachDevtools.md)
  - [`.SendAttachedPackagesToREnviron()`](https://jmbarbone.github.io/Rprofile/reference/attached_packages.md)
  - [`.UtilMessage()`](https://jmbarbone.github.io/Rprofile/reference/dot-UtilMessage.md)
