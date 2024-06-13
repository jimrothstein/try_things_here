#  sdtmchecks - practice area
library(sdtmchecks)
library(testthat)

PURPOSE: Understand R code for 1 check


  AE <- data.frame(
    USUBJID = 1:7,
    AETERM = 1:7,
    AESTDTC = 1:7,
    AEACNOTH = 1:7,
    AEACNOT1 = 1:7,
    AEACNOT2 = 1:7,
    AESPID = "FORMNAME-R:13/L:13XXXX"
  )

test_that("Function returns true when no errors are present", {
  expect_true(check_ae_aeacnoth(AE))
})

# TRUE
check_ae_aeacnoth(AE)


# -------------------
# run all, list 97


##:ess-bp-start::browser@nil:##
browser(expr=is.null(.ESSBP.[["@7@"]]));##:ess-bp-end:##
x=1
debug(run_all_checks)

all_rec<-run_all_checks(metads=sdtmchecksmeta, 
                         priority=c("High","Medium","Low"), 
                         type=c("ALL", "ONC", "COVID", "PRO"))

str(all_rec, max.level=1)

# isolate to ONE test, same as above (check_ae_aeacnoth)

the_check = sdtmchecksmeta |> dplyr::filter(check == "check_ae_aeacnoth")

X = run_all_checks(metads = the_check, type=c("ALL"))

str(X, max.level=1)
dput(X)
