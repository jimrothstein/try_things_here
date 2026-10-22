# 06_pivot_longer_wider_religious_income.R

# REF?
# ------------ relig_income----------------------------------
##  Normalize!   Create all combos religion x income,
relig_income
str(relig_income)

# ----------------------------------------
#   Problem:   Columns holding variables
# ----------------------------------------
relig2 <- relig_income %>%
  tidyr::pivot_longer(
    cols = 2:11, # also cols=-religion
    names_to = "income",
    values_to = "freqency"
  )
relig2
