#
# file <- "BASE/0415_rrapply_examples.R##"
file <- "46_rrapply_recurse_attr.R#"

PURPOSE:   how="recurse", strip away attrib using c(x)
# --------------------
##
library(rrapply)
library(listviewer)
data(package = "rrapply")

str(renewable_energy_by_country, list.len=3)  
# ----------------------------------------------------------

renewable_oceania <- renewable_energy_by_country[["World"]]["Oceania"]
#

# ----------------------------------------------------------
##  f strips away attr()
##  how = "recurse" ,   go into any list
##  classes = c("list")

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
