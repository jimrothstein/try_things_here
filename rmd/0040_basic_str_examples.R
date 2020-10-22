# rmd/040_basic_str_examples.R 

# ===================================================
# FUTURE
#   BASIC str( X, max.level, vec.length)  examples.
# see:
# http://stat545.com/block006_care-feeding-data.html
# ===================================================

library(purrr)
library(repurrrsive)
library(listviewer)


# Clean up
str(got_chars, max.level = 1)
str(got_chars[1], max.level = 2)        # 1st character, 
str(got_chars[1]$titles, max.level = 2)        # 1st character, 

got_chars[[1]]$titles
got_chars
str(got_chars)
length(got_chars)
