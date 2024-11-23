## 022

### Compare result from running

### check_ae_aecnoth(AE) function vs

### run_check() the same check (and only one check) is chosen
##
##  NOTE:   run_check() requires `ae` be in environment
library(sdtmchecks)

head(sdtmchecksmeta)

## Pick a check (check_ae_aeacnoth):  TWO ways
# one row
the_check <- sdtmchecksmeta |> dplyr::filter(check == "check_ae_aeacnoth")
the_check

#
metads <- sdtmchecksmeta[sdtmchecksmeta$check == "check_ae_aeacnoth", ]

metads
identical(the_check, metads)
# ---------

# Populate dummy AE
# (Assuming sdtm datasets are in your global environment)

AE <- data.frame(
  USUBJID = 1:7,
  AETERM = 1:7,
  AESTDTC = 1:7,
  AEACNOTH = 1:7,
  AEACNOT1 = 1:7,
  AEACNOT2 = 1:7,
  AESPID = "FORMNAME-R:13/L:13XXXX"
)

# pass
check_ae_aeacnoth(AE)


#  modified
AE1 <- AE

AE1$AEACNOTH[1] <- ""
AE1$AEACNOT1[1] <- ""
AE1$AEACNOT2[1] <- ""
AE1$AEACNOTH[2] <- "MULTIPLE"
AE1$AEACNOT1[2] <- "DOSE REDUCED"
AE1$AEACNOT2[2] <- "DRUG WITHDRAWN"
AE1$AEACNOTH[3] <- "MULTIPLE"
AE1$AEACNOT1[3] <- "DOSE REDUCED"
AE1$AEACNOT2[3] <- ""
AE1$AEACNOTH[4] <- "MULTIPLE"
AE1$AEACNOT1[4] <- ""
AE1$AEACNOT2[4] <- "DRUG WITHDRAWN"
AE1$AEACNOTH[5] <- "MULTIPLE"
AE1$AEACNOT1[5] <- ""
AE1$AEACNOT2[5] <- ""

# fail
check_ae_aeacnoth(AE1)
check_ae_aeacnoth(AE1, preproc = roche_derive_rave_row)


metads$check

# First, expect pass
# no output
rec <- run_check(
  check = metads$check,
  fxn_in = metads$fxn_in,
  xls_title = metads$xls_title,
  pdf_title = metads$pdf_title,
  pdf_subtitle = metads$pdf_subtitle,
  pdf_return = metads$pdf_return,
  verbose = T
)

rec[[1]]

rec[[2]]
attributes(rec)
rec$xls_title
rec$msg
rec$data

# Second
## expect fail , again no output
AE <- AE1

rec
rec$msg
rec$data
#


# Third, fail, now output !
ae <- AE1
rec

# Compare this to  simple function
res2 <- check_ae_aeacnoth(ae)
res2
attr(res2, "data")


res2$data

rec$data
# TRUE
identical(rec$data, attr(res2, "data"))
