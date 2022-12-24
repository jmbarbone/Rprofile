# Rprofile (development)

* Adds `.GitPrepareCommitMsg()` to copy one of two templates to `.git/hook/prepare-commit-msg` [#10]

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
