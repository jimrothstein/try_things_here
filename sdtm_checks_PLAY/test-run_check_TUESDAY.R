library(sdtmchecks)
library(testthat)

load_all()

### Experimental  (check_ae_aeacnoth)

###  One possible approach to testing the function `run_check()`

### Compare result function `check_ae_aeacnoth` to `run_check()` for same data.

### The data is dummy data, copied from example in check_ae_aeacnoth.R


### To generalize:
###    One approach might be to collect a number of dummy datasets previously used as examples.


### Assemble dummy datatests (nested list)
L <- check_dummy_datasets()

L


### Select single check
metads <- sdtmchecksmeta |> dplyr::filter(check == "check_ae_aeacnoth")
metads$check


test_that("Expect pass when valid dummy dataset is used", {
  ### Select one dummy dataset

  AE <- L[[c("check_ae_aeacnoth", "pass", "one")]]

  AE

  ae <- AE

  # PROBLEM    function run_check() looks for `ae` in its enclosing environemnt
  ### compare, when expect pass:
  result1 <- check_ae_aeacnoth(AE)
  result1

  result2 <- run_check(
    check = metads$check,
    fxn_in = metads$fxn_in,
    xls_title = metads$xls_title,
    pdf_title = metads$pdf_title,
    pdf_subtitle = metads$pdf_subtitle,
    pdf_return = metads$pdf_return,
    verbose = T
  )

  expect_true(
    identical(
      attr(result1, "msg"), result2$msg
    )
  )

  expect_true(
    identical(
      attr(result1, "data"), result2$data
    )
  )
})

#
### compare, when expect fail
AE <- L[[c("check_ae_aeacnoth", "fail", "one")]]
ae <- AE

result1 <- check_ae_aeacnoth(AE)
result1
c(result1)


#
result2 <- run_check(
  check = metads$check,
  fxn_in = metads$fxn_in,
  xls_title = metads$xls_title,
  pdf_title = metads$pdf_title,
  pdf_subtitle = metads$pdf_subtitle,
  pdf_return = metads$pdf_return,
  verbose = T
)
result2

expect_true(
  identical(
    attr(result1, "msg"), result2$msg
  )
)

expect_true(
  identical(
    attr(result1, "data"), result2$data
  )
)
