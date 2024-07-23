# metatools (see atorus) 
# From one dbl (age), create pair: grouping (AGEGR1) as string, AND create numbering (AGEGR1N)

library(metacore)
library(metatools)
library(haven)
library(dplyr)

# https://github.com/atorus-research/metacore/tree/main/inst/extdata
load(metacore_example("pilot_ADaM.rda"))  # copied from atorus/metaa

# R6 object, filled with functions, db
spec <- metacore %>% select_dataset("ADSL")
spec
str(spec)

# USUBJID, AGE  only
dm <- read_xpt(metatools_example("dm.xpt")) %>%
  select(USUBJID, AGE)
dm

# AGE, AGEGR1 = category (chr)
# Grouping Column Only
create_cat_var(dm, spec, AGE, AGEGR1)

# above, plus AGEGR1N = dbl
# Grouping Column and Numeric Decode
create_cat_var(dm, spec, AGE, AGEGR1, AGEGR1N)

