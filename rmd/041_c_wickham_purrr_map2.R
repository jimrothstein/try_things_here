# 041_c_wickham_purrr_map2.R

#
# source: https://www.youtube.com/watch?v=b0ozKTUho0A
#

# ---- 000-begin ----

rm(list=ls())
library(tidyverse)
library(purrr)
library (devtools)
library(repurrrsive)
source("040_jennybc_function_what_is_it.R")
#library("jimPackage")

# ---- 000-show datasets ----
data(package = "repurrrsive") # lists in new tab
browseVignettes(package="repurrrsive") # none
help.search("repurrrsive") # opens help

# ---- 001-map2_practice ----
?gap_split  # purrr::gapminder dataset
what_is_it(gap_split) # a list of length 142
str(gap_split, max.level = 1, list.len = 10) # limit to 10 entries

# study just 1
str(gap_split[[1]],max.level = 2, list.len=10)
glimpse(gap_split[[1]])   # most helpful

# @ 14:02
# plot Afganistan only
names <- names(gap_split)	# vector of chr (names)
g <- ggplot(gap_split[[1]], aes(x=year,y = lifeExp) )
g + geom_line() + labs(title= names[[1]])

gap_split_small <- gap_split[1:10]  # 10 countries only
df <- gap_split_small # list of 10 tibbles
names <- names(gap_split_small) # character vector of 10 country names
what_is_it(gap_split_small)   # list of 10 names tibbles
what_is_it(names)        # character vector, length 10
       
# try with map2
f <- function(df,names) {
        ggplot(df, aes(x=year,y = lifeExp) ) +
	geom_line() + labs(title= names)
}
map2(.x = df, .y = names, .f = f)

#   watch her

what_is_it(gap_split_small)   # list of 10 names tibbles
 
what_is_it(names)        # character vector, length 10
#
####  002-Named List ####
#
# Compare TWO lists, holding a single element, a tibble
# One list names the element, the other does not
       
ex_tibble <- tibble(a=c(1,2,3),
		    b=c("hi","bye","joe")
)

# check ex_tibble itself is named
ex_tibble["a"]	# returns tibble named a
ex_tibble[["a"]]	# returns contents of a

# TWO lists
# list containing tibble,no name 
list_unnamed <-list(ex_tibble)
list_unnamed[[1]]
str(list_unnamed)
# list containing tibble, WITH name
       list_named <-list(myName=tibble( a=c(1,2,3), 
                        b=c("hi","bye","joe")
                        )
)
list_named[["myName"]]
str(list_named)
#### 003-save plots as tibble ####
# @20:00

plots <- map2(.x = df, .y = names, .f = f)

map2( .x = df, .y=countries, ~ggsave(.x, plot= , device="png")


# =============================
# simple split , map example?
# =============================
mtcars %>% 
  split(.$cyl)->data
data

# not a summary, why do this?
# each group, add count column  with number of entries of this am.
purrr::map(data,~dplyr::add_count(.,am))->op1
op1

# this is gives summary:
purrr::map(data,~dplyr::count(.,am))->op1
op1

purrr::map(data,~dplyr::filter(.,mpg>=20))->op2
op2
