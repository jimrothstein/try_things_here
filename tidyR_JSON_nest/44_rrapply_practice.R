# file <- "44_rrapply_practice.R#"
##
# --------------------
##          RRAPPLY::  This file is PRACTICE ONLY.

##  use give.attr = F (cleaner output)
##  list.len = 3
##  max.depth = 1 or 2
##  use listenviewer::jsonedit, even though no JSON
# --------------------
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
# ---------------------------------------------------------------



# ----------------------------------  ASIDE -------------------------------------
# Extract oceania$Austrailia_and_NZ
  str(australia_new_zealand  <- oceania[[1]], list.len=4, give.attr = F) 
  str(australia_new_zealand, list.len=4)                ##  list of 6

  is.list(australia_new_zealand)
  # [1] TRUE
#
# list all attriibutes
  attributes(australia_new_zealand)

##  unlist, atomic but keeps names attriubtes
  u  <- unlist(australia_new_zealand)
  is.atomic(u)                      
  u

##  uname
  unname(u)
#
# NOTE:  as_tibble for australia_new_zealan, keeps attributes
  t  <- as_tibble(australia_new_zealand)
  str(t)
# -----------------------------------------------------------------------



# ---------    oceania & rrapply -------------------------------------------------
##  Cocos Islands has no number, in fact, is logical:NA;    
##  prune will keep numberic rows, drop others 
rrapply::rrapply(oceania,
                f = \(x) x,
                classes = "numeric",
                how  = "prune"
) |> str(list.len=3, give.attr=F)                 # as   
# ---------------------------------------------------------------


##  keep logical, remove all others !
rrapply::rrapply(oceania,
                f = \(x) x,
                classes = "logical",
                how  = "prune"
) |> str(list.len=3, give.attr=F)                 # as   
# ---------------------------------------------------------------

##  keep only if less than 10, works w or w/o classes="numeric"
# ---------------------------------------------------------------
rrapply::rrapply(oceania,
                f = \(x) x,
                condition = \(x) x <10, 
                classes = "numeric",
                how  = "prune"
) |> str(list.len=3, give.attr=F)                 # as   
# ---------------------------------------------------------------

# ---------------------------------------------------------------
#  replace all logical to 0 for countries with missing values (NA), but do not drop
rrapply::rrapply(oceania,
                f = \(x) 0,
                classes = "logical",
                how  = "replace"
) |> str(list.len=3, give.attr=F)                 # as   
# ---------------------------------------------------------------


# -------------------------------------------------------------------------------
## prune , flatten (to named atomic vector double[])
## Lost structure (Oceania, Region, Country)
z  <- rrapply::rrapply(oceania,
                classes = "numeric",
                how  = "flatten"
) 
z
##  double[]
typeof(rrapply::rrapply(oceania,
                classes = "numeric",
                how  = "flatten"
))



# ----------------------------------------------------
## Beautiful, z is named list, str shows contents named double[]
## named list, with `structure` recorded! (if not kept )
#
z  <- rrapply::rrapply(oceania,
                classes = "numeric",
                how  = "flatten",
                options = list(namesep=".", simplify = F)

) 
z |> str(list.len=10, give.attr=F) 

# ---------------------------------------------------------------
listviewer::jsonedit(z)


# ----------------------------------------------------------
##  melt, includes prune
## drop all logical NA's and return melted data.frame
## note:  something going on with attr
  oceania_melt <- rrapply(
    oceania,
    classes = "numeric",
    how = "melt"
  ) 

  head(oceania_melt, n = 10)   # note:  L1, L2
# -----------------------------------------------------


# -----------------------------------------------------
##  unmelt,  only works if list was melted with rrapply?
# --------------------------------------------------------
#
#
#
##
##
# -----------------------------------------------------
##  how=bind     POKEDEX
listviewer::jsonedit(pokedex)

rrapply(pokedex, how = "bind")[, c(1:3, 5:8)] |>
  head(n = 10)
# ------------
