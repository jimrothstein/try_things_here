#  Getting Started Vignette:

# Uncomment line below if you need to install these packages
##:

# install.packages(c("dplyr", "lubridate", "stringr", "tibble", "pharmaversesdtm", "admiral"))

library(dplyr, warn.conflicts = FALSE)
library(lubridate)
library(stringr)
library(tibble)
library(pharmaversesdtm)   # source of dummy data
library(admiral)

# Read in SDTM datasets
data("dm")
data("ds")
data("ex")
data("vs")
data("admiral_adsl")

ls()
# structure of dm?   has attribute: label
str(dm, max.level=1)
attributes(dm)

# structure of admiral_adsl
dim(admiral_adsl)
str(admiral_adsl)



##  Add variables, 2
##  TODO:   show new variables 
dim(ex)

ex_ext <- ex %>%
  derive_vars_dtm(
    dtc = EXSTDTC,
    new_vars_prefix = "EXST"
  )
dim(ex_ext)
names(ex_ext)



##  Add records

## find records
dim(vs)
vs_new <- vs %>%
  dplyr::filter(
    USUBJID %in% c(
      "01-701-1015", "01-701-1023", "01-703-1086",
      "01-703-1096", "01-707-1037", "01-716-1024"
    ) &
      VSTESTCD %in% c("SYSBP", "DIABP") &
      VSPOS == "SUPINE"
  )

dim(vs_new)

adsl <- admiral_adsl %>%
  select(-TRTSDTM, -TRTSTMF)
dim(adsl)

names(vs)
advs <- vs %>%
  mutate(
    PARAM = VSTEST, PARAMCD = VSTESTCD, AVAL = VSSTRESN, AVALU = VSORRESU,
    AVISIT = VISIT, AVISITN = VISITNUM
  )
names(advs)


# read or download *.rda file from github repo
githubURL = "https://github.com/pharmaverse/pharmaverseadam/blob/main/data/adae.rda?raw=true"
temf = tempfile("temp_adae", fileext=".rda")
download.file(githubURL, temf, mode="wb")
load(temf)

