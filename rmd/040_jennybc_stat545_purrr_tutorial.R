# 040_jennybc_stat_purrr_tutorial

rm(list=ls())

# see:
# 
# http://stat545.com/block006_care-feeding-data.html

library(purrr)
library(repurrrsive)
library(listviewer)

# play with map
(z <- map (c(4,16,64), sqrt))  # apply function to vector, always returns list
str(z, max.level = 1)   # a list of 3, each num


#######################
able3 # tb rates

?repurrrsivi
str(got_chars, max.level = 1)
str(got_chars[1], max.level = 2)        # 1st character, 
str(got_chars[1]$titles, max.level = 2)        # 1st character, 

got_chars[[1]]$titles
got_chars
str(got_chars)
length(got_chars)
