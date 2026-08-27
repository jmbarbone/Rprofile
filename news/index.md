# Changelog

## Rprofile (development version)

### New features

- [`.ReadClip()`](https://jmbarbone.github.io/Rprofile/reference/dot-ReadClip.md)
  added to read clipboard contents \[#31\]
- [`.GithubRelease()`](https://jmbarbone.github.io/Rprofile/reference/dot-GithubRelease.md)
  added to create a GitHub (pre)release \[#29\], \[#41\]
- [`.FindRprofile()`](https://jmbarbone.github.io/Rprofile/reference/Rprofile-file.md)
  added to find your `.Rprofile` file; used within
  [`.Rprofile()`](https://jmbarbone.github.io/Rprofile/reference/Rprofile-file.md)
  \[#23\]
- [`.LintFile()`](https://jmbarbone.github.io/Rprofile/reference/dot-LintFile.md)
  added for selecting individual files to `lint` (defaults to currently
  opened file) \[#21\]
- [`.GitPrepareCommitMsg()`](https://jmbarbone.github.io/Rprofile/reference/dot-GitPrepareCommitMsg.md)
  added to copy one of two templates to `.git/hook/prepare-commit-msg`
  \[#10\]
- [`.OpenFile()`](https://jmbarbone.github.io/Rprofile/reference/OpenFile.md)
  added to open a file path or an object inside a file \[#6\]
- [`.GlobalHandle()`](https://jmbarbone.github.io/Rprofile/reference/dot-GlobalHandle.md)
  added to call
  [`rlang::global_handle()`](https://rlang.r-lib.org/reference/global_handle.html);
  added into
  [`.RprofileJordan()`](https://jmbarbone.github.io/Rprofile/reference/dot-RprofileJordan.md)
- [`.OpenFile()`](https://jmbarbone.github.io/Rprofile/reference/OpenFile.md)
  added as an alias for
  [`.FileOpen()`](https://jmbarbone.github.io/Rprofile/reference/OpenFile.md)
- [`.GitHubRelease()`](https://jmbarbone.github.io/Rprofile/reference/dot-GithubRelease.md)
  added as an alias for
  [`.GithubRelease()`](https://jmbarbone.github.io/Rprofile/reference/dot-GithubRelease.md)
- [`.Pak()`](https://jmbarbone.github.io/Rprofile/reference/dot-Pak.md)
  added as a wrapper for
  [`pak::pak()`](https://pak.r-lib.org/reference/pak.html)
- [`.Air()`](https://jmbarbone.github.io/Rprofile/reference/dot-Air.md)
  added to call `air format .`
- [`.UseGithubAction()`](https://jmbarbone.github.io/Rprofile/reference/dot-UseGithubAction.md)
  (alias
  [`.UseGitHubAction()`](https://jmbarbone.github.io/Rprofile/reference/dot-UseGithubAction.md))
  added to copy a GitHub Action workflow template to
  `.github/workflows/`
- [`.RemoveGlobalConflicts()`](https://jmbarbone.github.io/Rprofile/reference/dot-RemoveGlobalConflicts.md)
  added to remove global conflicts

### Fixes

- Improves checking for `R_PROFILE` envvar
- `.Rprofile(TRUE)` should work again with correction to internal `sf()`
- [`.CheckCranStatus()`](https://jmbarbone.github.io/Rprofile/reference/dot-CheckCranStatus.md)
  has simplified output when [cli](https://cli.r-lib.org) is available;
  linked included to packages \[#8\]
- [`.CheckCranStatus()`](https://jmbarbone.github.io/Rprofile/reference/dot-CheckCranStatus.md)
  specifically sets temporary file for check status results
- [`.CheckCranStatus()`](https://jmbarbone.github.io/Rprofile/reference/dot-CheckCranStatus.md)
  outputs corrected
- [`.Rprofile()`](https://jmbarbone.github.io/Rprofile/reference/Rprofile-file.md)
  now uses
  [`fs::path_expand_r()`](https://fs.r-lib.org/reference/path_expand.html)
  to resolve tilde expansions, e.g., with `"~/.Rprofile"` \[#23\]
- [`.CheckCranStatus()`](https://jmbarbone.github.io/Rprofile/reference/dot-CheckCranStatus.md)
  now (again?) exits quietly when an email is not found
- [`.NewsUrls()`](https://jmbarbone.github.io/Rprofile/reference/dot-NewsUrls.md)
  paths corrected and no longer errors

### Enhancements

- [`.GithubRelease()`](https://jmbarbone.github.io/Rprofile/reference/dot-GithubRelease.md)
  now prompts for both `publish` and `pre-release` params when they are
  not set
- [`.RprofileJordan()`](https://jmbarbone.github.io/Rprofile/reference/dot-RprofileJordan.md)
  checks for additional library paths from envvars `R_LIBS_PAK` and
  `R_LIBS_SCRIBE`
- [`.UsePackageLibrary()`](https://jmbarbone.github.io/Rprofile/reference/dot-UsePackageLibrary.md)
  appends a new path to the library path based on the directory of the
  package
- `.Search(pattern)` now allows for pattern matching \[#38\]
- [`.Rprofile()`](https://jmbarbone.github.io/Rprofile/reference/Rprofile-file.md)
  gains a `path` argument (with defaults) for identifying an `.Rprofile`
  location \[#23\]
- [`.GitBranchPrompt()`](https://jmbarbone.github.io/Rprofile/reference/dot-GitBranchPrompt.md)
  now uses a function and doesn’t require manual runs to update branch
  \[#43\]
- [`.FileOpen()`](https://jmbarbone.github.io/Rprofile/reference/OpenFile.md)
  now normalizes a path for a file before attempting to open
- [`.GitBranchPrompt()`](https://jmbarbone.github.io/Rprofile/reference/dot-GitBranchPrompt.md)
  has been simplified
- [`.NewsUrls()`](https://jmbarbone.github.io/Rprofile/reference/dot-NewsUrls.md)
  now has prettier print for differences; URLs detected are highlighted
  with [crayon](https://r-lib.github.io/crayon/) and only the changed
  lines (with line numbers) are printed
- Improvements with package checking
- Prompts via [`utils::menu()`](https://rdrr.io/r/utils/menu.html)
  cleaned up
- Additional namespaces will be unloaded if they not already loaded

### Internal

- `@jmbarbone`’s preferred settings are now included as
  [`.RprofileJordan()`](https://jmbarbone.github.io/Rprofile/reference/dot-RprofileJordan.md),
  now a single command I can run in my `.Rprofile`
- package `lint`ing now included
- A new `..Rprofile` environment will be created on start-up as a copy
  of an internal package environment
- [fuj](https://jmbarbone.github.io/fuj/) is now imported
- [magrittr](https://magrittr.tidyverse.org) removed as an import

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
