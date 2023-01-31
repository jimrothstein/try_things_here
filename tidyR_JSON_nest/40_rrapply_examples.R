#
# file <- "BASE/0415_rrapply_examples.R##"
##
# --------------------
##          RRAPPLY::
# --------------------

##
library(rrapply)
data(package = "rrapply")

# ----------------------------------------------------------
str(pokedex , list.len=3)
str(renewable_energy_by_country, list.len=3)  
str(renewable_energy_by_country$World$Oceania, list.len=3)

##  give.attr=F (cleaner):w
##  
str(renewable_energy_by_country$World$Oceania, list.len=3, give.attr = F)
# ----------------------------------------------------------


#
# ------- pop off 2 levels, oceania & oceania[[1]] = ANZ ---------------------
oceania  <- renewable_energy_by_country$World$Oceania
str(oceania, list.len=4 , give.attr = F)

# 1 more level
str(australia_new_zealand  <- oceania[[1]], list.len=4, give.attr = F) 
australia_new_zealand

# check, atomic?   tibble? 
u  <- unlist(australia_new_zealand)
is.atomic(u)
# [1] TRUE
#
# NOTE:  as_tibble for australia_new_zealan
t  <- as_tibble(australia_new_zealand)
t



# ---------    oceania & rrapply -------------------------------------------------
##  Cocos Islands has no number, prune will drop 
##  give.attr=F much cleaner w/o attributes
rrapply::rrapply(oceania,
                f = \(x) x,
                classes = "numeric",
                how  = "prune"
) |> str(list.len=3, give.attr=F)                 # as   


#  replace logical to 0 for countries with missing values.
rrapply::rrapply(oceania,
                f = \(x) 0,
                classes = "logical",
                how  = "replace"
) |> str(list.len=3, give.attr=F)                 # as   

## prune , flatten (to double[])
rrapply::rrapply(oceania,
                classes = "numeric",
                how  = "flatten"
) |> head(10)

## Beautiful, returns double[]
z  <- rrapply::rrapply(oceania,
                classes = "numeric",
                how  = "flatten",
                options = list(namesep=".", simplify = F)

) |> str(list.len=10, give.attr=F) 
is.atomic(z)
