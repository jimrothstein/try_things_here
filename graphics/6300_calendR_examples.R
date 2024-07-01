# 	file <- "6300_calendR_examples.R"
#
library(calendR)

## 	package info, including options in calendR?
{
  sessioninfo::session_info()
  .Options[grep("calendR", names(.Options))]
}
{
  calendR()
}


## 	chronology
{
  calendR(
    title = "ITCHING:   Chronology",
    month = 6,
    special.days = c(2)
  )
}
