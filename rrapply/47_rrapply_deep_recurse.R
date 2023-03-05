file <- "47_rrapply_deep_recurse.R#"

PURPOSE:   Deeply nested lists, !s0 63895533 (STUDY)
- create df
- tibble really helps understand structure (vs df)

# --------------------
##
library(rrapply)
library(tidyr)
library(listviewer)
# ----------------------------------------------------------

# ----------------------------------------------------------
##  f strips away attr()
##  how = "recurse" ,   go into any list
##  classes = c("list")

ls <- list('10' = list('123' = list('0.1' = list(Gmax.val = rnorm(1),
                                                 G2.val = rnorm(1),
                                                 Gmax.vec = rnorm(8),
                                                 G2.vec = rnorm(8)),
                                    '0.2' = list(Gmax.val = rnorm(1),
                                                 G2.val = rnorm(1),
                                                 Gmax.vec = rnorm(8),
                                                 G2.vec = rnorm(8))),
                       '456' = list ('0.1' = list(Gmax.val = rnorm(1),
                                                  G2.val = rnorm(1),
                                                  Gmax.vec = rnorm(8),
                                                  G2.vec = rnorm(8)),
                                     '0.2' = list(Gmax.val = rnorm(1),
                                                  G2.val = rnorm(1),
                                                  Gmax.vec = rnorm(8),
                                                  G2.vec = rnorm(8)))),
           '20' = list('123' = list('0.1' = list(Gmax.val = rnorm(1),
                                                 G2.val = rnorm(1),
                                                 Gmax.vec = rnorm(8),
                                                 G2.vec = rnorm(8)),
                                    '0.2' = list(Gmax.val = rnorm(1),
                                                 G2.val = rnorm(1),
                                                 Gmax.vec = rnorm(8),
                                                 G2.vec = rnorm(8))),
                       '456' = list ('0.1' = list(Gmax.val = rnorm(1),
                                                  G2.val = rnorm(1),
                                                  Gmax.vec = rnorm(8),
                                                  G2.vec = rnorm(8)),
                                     '0.2' = list(Gmax.val = rnorm(1),
                                                  G2.val = rnorm(1),
                                                  Gmax.vec = rnorm(8),
                                                  G2.vec = rnorm(8)))))

listviewer::jsonedit(ls)


# ----------------------------MELT------------------------------
set.seed(2023)
one  <- rrapply(ls, how="melt")
one  <- as_tibble(one)
one |> head()
names(one)
# [1] "L1"    "L2"    "L3"    "L4"    "value"
str(one, list.len=3)
# 'data.frame':	32 obs. of  5 variables:
#  $ L1   : chr  "10" "10" "10" "10" ...
#  $ L2   : chr  "123" "123" "123" "123" ...
#  $ L3   : chr  "0.1" "0.1" "0.1" "0.1" ...
#   [list output truncated]
# NULL
# ----------------------------------------------------------



# ---------------------------- BIND better------------------------------
two  <- rrapply(ls, how="bind", options=list(namecols=T)) 
two  <- as_tibble(two)
two |> head(3)
# # A tibble: 3 × 7
#   L1    L2    L3    Gmax.val  G2.val Gmax.vec  G2.vec   
#   <chr> <chr> <chr>    <dbl>   <dbl> <list>    <list>   
# 1 10    123   0.1     -1.19   0.0649 <dbl [8]> <dbl [8]>
# 2 10    123   0.2     -0.292 -0.696  <dbl [8]> <dbl [8]>
# 3 10    456   0.1      0.852  2.57   <dbl [8]> <dbl [8]>
str(two, list.len=4)

##  how to do with just rrapply?
tidyr::unnest_longer(two, c("Gmax.vec", "G2.vec"))
# ----------------------------------------------------------
#

# ----------------------------------------------------------
LEGACY
{
rrapply( 
  renewable_oceania,
  f = \(x) c(x),
  classes = c( "list", "ANY"),
  how = "recurse"
) |> str(list.len = 3, give.attr = TRUE) 
}
List of 1
 $ Oceania:List of 4
  ..$ Australia and New Zealand:List of 6
  .. ..$ Australia                        : num 9.32
  .. ..$ Christmas Island                 : logi NA
  .. ..$ Cocos (Keeling) Islands          : logi NA
  .. .. [list output truncated]
  ..$ Melanesia                :List of 5
  .. ..$ Fiji            : num 24.4


 ----------------------------------------------------------
