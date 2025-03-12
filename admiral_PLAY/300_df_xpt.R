#  PURPOSE:   Write *.xpt file
#  xportx does several things,   can read, can add metadata, can check ... and write xpt 

#  df -> SAS transport file, v 5
library(xportr)


# toy df
adsl <- data.frame(
  SUBL = as.character(123, 456, 789),
  DIFF = c("a", "b", "c"),
  VAL = c("1", "2", "3"),
  PARAM = c("param1", "param2", "param3")
)

# 1 row, metadata
var_spec <- data.frame(
  dataset = "adsl",
  label = "Subject-Level Analysis Dataset",
  data_label = "ADSL"
)
var_spec

tempdir()
xportr_write(adsl,
             path = paste0(tempdir(), "/adsl.xpt"),
             domain = "adsl",
             metadata = var_spec,
             strict_checks = FALSE
)


