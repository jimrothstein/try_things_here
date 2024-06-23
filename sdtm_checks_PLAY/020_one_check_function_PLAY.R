#  sdtmchecks - practice area
library(sdtmchecks)
library(testthat)

# function:   check_ae_aeacnoth()

# PURPOSE: Understand R code for 1 check function: (vary input df, AE) 
### ie functions of the form: check_ae_aeacnoth(AE)
### in next R file, compare   `run_check` for the SAME test



# should pass
  AE1 <- data.frame(
    USUBJID = 1:7,
    AETERM = 1:7,
    AESTDTC = 1:7,
    AEACNOTH = 1:7,
    AEACNOT1 = 1:7,
    AEACNOT2 = 1:7,
    AESPID = "FORMNAME-R:13/L:13XXXX"
  )


test_that("Function returns true when no errors are present", {
  expect_true(check_ae_aeacnoth(AE1))
})

# TRUE
check_ae_aeacnoth(AE)


# -------------------
# run all, list 97


# -------------------
# Change AE so it fails
# -------------------

  AE2 <- data.frame(
    #USUBJID = 1:7,
    AETERM = 1:7,
    AESTDTC = 1:7,
    AEACNOTH = 1:7,
    AEACNOT1 = 1:7,
    AEACNOT2 = 1:7,
    AESPID = "FORMNAME-R:13/L:13XXXX"
  )

# Fails AND  get msg
x = check_ae_aeacnoth(AE2)

typeof(x)

attributes(x)

str(x, max.level = 1)
# -------------------

