test_that("reg_extract_gh_account()", {
  obj <- reg_extract_gh_account("https://github.com/jmbarbone/Rprofile")
  exp <- "jmbarbone"
  expect_identical(obj, exp)

  obj <- reg_extract_gh_account("https://github88name.github.io/packageName/")
  exp <- "github88name"
  expect_identical(obj, exp)

  obj <- reg_extract_gh_account("https://github.com/github88name/packageName")
  exp <- "github88name"
  expect_identical(obj, exp)
})
