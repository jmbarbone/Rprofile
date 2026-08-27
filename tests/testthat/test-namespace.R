test_that("reset_namespaces()", {
  loaded <- loadedNamespaces()
  reset_namespaces({
    gh::gh
    mark::mark_write_methods()
    expect_false(setequal(loadedNamespaces(), loaded))
  })
  expect_setequal(loadedNamespaces(), loaded)
})

test_that("reset_namespaces() works with failures", {
  loaded <- loadedNamespaces()
  expect_error(
    reset_namespaces({
      fuj::quick_df(1)
    }),
    class = "type_error"
  )
  expect_setequal(loadedNamespaces(), loaded)
})
