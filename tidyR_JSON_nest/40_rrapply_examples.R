#
# file <- "BASE/0415_rrapply_examples.R##"
##
# --------------------
##          RRAPPLY::
# --------------------

##  use give.attr = F (cleaner output)
##  list.len = 3
##  max.depth = 1 or 2
##  use listenviewer::jsonedit, even though no JSON
##
library(rrapply)
library(listviewer)
data(package = "rrapply")

# ----------------------------------------------------------
str(pokedex , list.len=3)
str(renewable_energy_by_country, list.len=3)  
str(renewable_energy_by_country$World$Oceania, list.len=3)
str(renewable_energy_by_country$World$Oceania, list.len=3, give.attr = F)
# ----------------------------------------------------------


#
# ------- pop off 2 levels, oceania & oceania[[1]] = ANZ ---------------------
oceania  <- renewable_energy_by_country$World$Oceania
listviewer::jsonedit(oceania)
str(oceania, list.len=4 , give.attr = F)


# ----------------------------------  ASIDE -------------------------------------
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
# -----------------------------------------------------------------------



# ---------    oceania & rrapply -------------------------------------------------
##  Cocos Islands has no number, in fact, is logical:NA;    
##  prune will keep numberic rows, drop others 
rrapply::rrapply(oceania,
                f = \(x) x,
                classes = "numeric",
                how  = "prune"
) |> str(list.len=3, give.attr=F)                 # as   


#  replace logical to 0 for countries with missing values (NA), but do not drop
rrapply::rrapply(oceania,
                f = \(x) 0,
                classes = "logical",
                how  = "replace"
) |> str(list.len=3, give.attr=F)                 # as   


## prune , flatten (to named atomic vector double[])
rrapply::rrapply(oceania,
                classes = "numeric",
                how  = "flatten"
) 

typeof(rrapply::rrapply(oceania,
                classes = "numeric",
                how  = "flatten"
))



## Beautiful, z is list, str shows contents named double[]
z  <- rrapply::rrapply(oceania,
                classes = "numeric",
                how  = "flatten",
                options = list(namesep=".", simplify = F)

) |> str(list.len=10, give.attr=F) 


