# 039_jennybc_stat_gapminder

rm(list=ls())

# see:
# http://stat545.com/block006_care-feeding-data.html



# do ONCE
#install.packages("gapminder")


library(gapminder)
library(tidyverse)
library(stringr)  # not yet core package in tidyverse

#################################################
# BOTH work
source("040_jennybc_function_what_is_it.R")
source("./jimPackage/R/what_is_it.R")

# does NOT work
library(jimPackage)
#################################################

str(gapminder)
class(gapminder)


#######################
table3 # tb rates

# extract cases & population
class(table3)
is_tibble(table3)   # TRUE

table3$rate %>% str_split_fixed(pattern = "/", n = 2)
is_list(table3$rate %>% str_split_fixed(pattern = "/", n = 2)) # not tibble, not list

table3 %>%
        separate(rate,
                 into = c("cases", "population"), convert=TRUE)




########################
values <- c(1.8,22.6,39.3,108.6,10.6,19.0,10.1,3.0,25.2,155.1)
(sum(values))
(values/sum(values))
sum(values/sum(values))

sum(c(0.4,4.8,5.3,6.4,43.1,39.2,0.7))


sum(c(5.7,9.9,27.5))
purrr::is_character(c("hi","bye"))
purrr::is_atomic(c("hi","bye"))
purrr::is_character(c(12,3.1))
(v_int <- 1:4)
v_int
v_int[1:2]
v_int[0]
v_int[5]
v_char <- c("aaa","bbb")
purrr::is_atomic(v_char) # TRUE,  I thought FALSE
purrr::is_bare_character(v_char)  # TRUE
length(v_char[1])
is_scalar_character(v_char) # FALSE
is_scalar_character(v_char[1]) # TRUE
purrr::scalar
