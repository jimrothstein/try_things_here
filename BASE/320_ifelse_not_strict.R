

# ifelse
#
#
# normal use
  ifelse(3 >5, 1, -2)


# inconsistent, try to keep it only 1 class of inputs
  ifelse(3 >5, 1, "wrong")

# better:  strict,  throw an error early, rather than debug later.
  library(dplyr)
  if_else(3 >5, 1, -2)
  if_else(3 >5, 1, "wrong")
