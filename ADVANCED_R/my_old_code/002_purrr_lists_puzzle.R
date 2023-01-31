# 002_purrr_lists_puzzle.R

# http://r4ds.had.co.nz/vectors.html

# ----------------------------

## All this to calculate 2016 dollars
## Something happening with named vectors that
## I do not understand

# clean up
rm(list=ls())
library(tidyverse)

#-----------------------------
# create vector (this will be inflation)
v <- c(1,2,3)
what_is_it(v)  # default is double

#-----------------------------
# vector to name each element of v (instead of "2009Q3")
# check now
names(v)  # NULL, no names

n<-c("a","b","c")  
what_is_it(n)   # check this too!

# use purrr to set names
v<-purrr::set_names(v,n)
names(v)  # still NULL?

# what is v now?
what_is_it(v)  # passes same tests
#-----------------------------

# our goal is to give v a string ("2009Q3" or "b") and get a number (inflation)
# but ... look at few elements of v

# we ONLY want the value  ... problem!
v[2]  #  prints BOTH name and inflation value

# play, some more, all return BOTH name and value
v["b"]# returns b 2 (vertical)
v[c("c","a","a")] # returns c a a  then on new line 3 1 1
v[c(3,1,1)] 

#-------------------------------
# To obtain value ONLY, MUST use ..[[ ]]
v[[2]]   # 2 only
v[["c"]]  # 3 only


# -----------------------------
# Let's use v (now named) in THREE similar functions
# hint: this function appears in house_expenditures.R,
#       where QUARTER is string  like "2009Q3"

# choice 1, correct, returns value only (turns out this will fail)
multiply_by  <- function(QUARTER) {
        1 + v[[QUARTER]]
}

# choice 2,  wrong, returns BOTH name and value (yet this will work)
multiply_by_wrong <- function(QUARTER){
        1 + v[QUARTER]
}

# choice 3= kluge, return value only (and this also will work)
# This kluge is what I propose for real code.
multiply_by_kluge <-function(QUARTER){
        1 + as.numeric(v[QUARTER])
}

#
# -------------------------
# # which of the 3 functions to use?
# choice 1 and choice 3 return value only - good
# choice 2 returns value AND name - bad

multiply_by("a") # get value (2)
multiply_by_wrong("a") # get name + value (a 2)
multiply_by_kluge("a") # get value (2)

# so every thing looks good, so far, if use choice 1 or 3,  not 2

#--------------------------
# NOW, try in a dataframe, to act as real house expenses
#
# for QUARTER, instead of "2009Q3" I will stay with "a", both are strings
# for AMOUNT, keep it simple to $1.00

# our fake house expenses
df <-data.frame(AMOUNT=c(1,1,1,1),
                QUARTER=c("a","b","c","a"), 
                z=c("do","ray","me","do"))

print(df)

# calculate column for 2016 dollars, looking up the inflation!

# choice 1 (correct) -- gives error!
# choice 2 (wrong) -- works!
# choice 3 (kluge) -- works


house_expenditures_clean <- df %>%
        mutate('2016_dollars' = as.numeric("")) %>%
        mutate('2016_dollars' = 
                       round(AMOUNT* multiply_by_wrong(QUARTER),2)) %>%
        select(everything())  
house_expenditures_clean

#------------------------
# BOTTOM LINE
# Kluge works, but the correct way returns error!
# 


##  functions

# 
what_is_it <-function(v) {
        t<-tibble(test=
                          c("list",
                            "atomic",
                            "vector",
                            "numeric",
                            "integer",
                            "double",
                            "character",
                            "logical"),
                  result=
                          c(is_list(v),
                            is_atomic(v),
                            is_vector(v), 
                            is_numeric(v),
                            is_integer(v),
                            is_double(v),
                            is_character(v),
                            is_logical(v))
        )
        print(v)
        print(t)
        print(paste(c("typeof=",typeof(v))))
        
}      
