## 025

library(reprex)

reprex(std_out_err=T, {
  

## Problem:   sdtmchecks::run_check()  does not appear to work with dummy data only for AE 
## suspect code?   ae is not defined
  
## fxn_in="AE=ae"
## parse(text = paste0(check, "(", fxn_in, ")"))
  
library(sdtmchecks)

### Pick a check (check_ae_aeacnoth):
metads = sdtmchecksmeta[sdtmchecksmeta$check == "check_ae_aeacnoth", ]
metads$check

### Populate dummy AE
### "Assuming sdtm datasets are in your global environment"
   AE <- data.frame(
    USUBJID = 1:7,
    AETERM = 1:7,
    AESTDTC = 1:7,
    AEACNOTH = 1:7,
    AEACNOT1 = 1:7,
    AEACNOT2 = 1:7,
    AESPID = "FORMNAME-R:13/L:13XXXX"
   )

### check: pass
check_ae_aeacnoth(AE)

## run 2 ways, (1) ae not in environment (2) ae=AE

rec1 <- run_check(
  check = metads$check,
  fxn_in = metads$fxn_in,
  xls_title = metads$xls_title,
  pdf_title = metads$pdf_title,
  pdf_subtitle = metads$pdf_subtitle,
  pdf_return = metads$pdf_return,
  verbose = T
)


##
ae=AE

rec2 <- run_check(
  check = metads$check,
  fxn_in = metads$fxn_in,
  xls_title = metads$xls_title,
  pdf_title = metads$pdf_title,
  pdf_subtitle = metads$pdf_subtitle,
  pdf_return = metads$pdf_return,
  verbose = T
)
identical(rec1, rec2)

rec1$notes
rec2$notes


rec1
rec2

})

