### PURPOSE:    Combine multiple dummy datasets for check_ae_aeacnoth(AE).  In check_ae_aeacnoth.R, the original dummy dataset for AE is then modified, with same name AE, and re-tested.

### Here, each modified dataframe is given a new name AE1, AE2 ...


# Copied from  `check_ae_aeacnoth.R`

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

# another
AE2 <- AE1
AE2$AEACNOTH[1] <- NA
AE2$AEACNOT1[1] <- NA
AE2$AEACNOT2[1] <- NA
AE2$AEACNOT2[3] <- NA
AE2$AEACNOT1[4] <- NA
AE2$AEACNOT1[5] <- NA
AE2$AEACNOT2[5] <- NA

# fail
check_ae_aeacnoth(AE2)
check_ae_aeacnoth(AE2, preproc = roche_derive_rave_row)


AE3 <- AE2
AE3$AEACNOTH <- NULL
AE3$AEACNOT1 <- NULL
AE3$AEACNOT2 <- NULL
AE3$AESPID <- NULL
check_ae_aeacnoth(AE3)


### Here combine into one dataframe.   AE3 is not included several columns removed via NULL and therefore has a different structure.

AEcombined <- is.data.frame(rbind(AE, AE1, AE2))
AEcombined

check_ae_aeacnoth(AE)
check_ae_aeacnoth(AE1)
check_ae_aeacnoth(AEcombined)

# fails
check_ae_aeacnoth(c(AE, AE1))
