#  sdtmchecks - practice area
library(sdtmchecks)
library(testthat)

# PURPOSE: Understand R code for 1 check function: (vary input df, AE)
                                        # ie functions of the form: check_ae_aeacnoth(AE)


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



                                        
# run_all_checks(),   but select only 1 test, same as abovel and run with varying AE

#all_rec<-run_all_checks(metads=sdtmchecksmeta, 
                         priority=c("High","Medium","Low"), 
                         type=c("ALL", "ONC", "COVID", "PRO"))

#str(all_rec, max.level=1)

# isolate to ONE test, same as above (check_ae_aeacnoth)

AE=AE1
ae=AE1
the_check = sdtmchecksmeta |> dplyr::filter(check == "check_ae_aeacnoth")

X1 = run_all_checks(metads = the_check, type=c("ALL"))

X


#  repeat with different AE
AE=AE2
X2 = run_all_checks(metads = the_check, type=c("ALL"))

identical(X1, X2)
