# https://atorus-research.github.io/xportr/articles/xportr.html
# 310_adsl_sample_xpt.R

library(dplyr)
library(xportr)

# toy adsl ds,  306 x 51 (tibble)
data("adsl_xportr")
ADSL <- adsl_xportr
ADSL
str(ADSL)   # has attributes
attributes(ADSL$STUDYID)  # has attributesb
## returns FAILED   (character(0) means no errors)
xpt_validate(ADSL)

# get toy spec file (where xportx package is installed)

# [1] "/home/jim/R/x86_64-pc-linux-gnu-library/4.4/xportr/specs/ADaM_spec.xlsx"
spec_path <- system.file(file.path("specs", "ADaM_spec.xlsx"), package = "xportr")
spec_path


## Read using Google spreadsheets
## 1st TAB contents of .xlsx spec file   (others include:  datasets, documents, pre-defined ....)
# Attribute	Value
# StudyName	
# StudyDescription	< Protocol description>
#   ProtocolName	
# StandardName	SDTM-IG
# StandardVersion	3.1.3
# Language	en


## read specs from xlsx | rules for each field of db ADSL
var_spec <- readxl::read_xlsx(spec_path, sheet = "Variables") %>%
  dplyr::rename(type = "Data Type") %>%
  dplyr::rename_with(tolower)

## 51 x 19
var_spec
str(var_spec)


## 1 x 9  (describes ADSL file)  from xlsx
dataset_spec <- readxl::read_xlsx(spec_path, sheet = "Datasets") %>%
  dplyr::rename(label = "Description") %>%
  dplyr::rename_with(tolower)
 dataset_spec
 
 args(xportr)
## clean, using xportr functions
## write xpt file
 xportr(
   .df = ADSL,
   var_metadata = var_spec,
   df_metadata = dataset_spec,
   domain = "ADSL",
   verbose = "warn",
   "adsl.xpt"
 ) 
 