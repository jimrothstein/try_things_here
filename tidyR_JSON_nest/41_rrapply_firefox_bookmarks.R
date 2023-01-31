#
##  Compare to base::rapply
##
library(rrapply)
data(package = "rrapply")

str(pokedex , list.len=3)
str(renewable_energy_by_country, list.len=3)  
str(renewable_energy_by_country$World$Oceania, list.len=3)

##  give.attr=F (cleaner):w
##  
str(renewable_energy_by_country$World$Oceania, list.len=3, give.attr = F)


oceania  <- renewable_energy_by_country$World$Oceania
str(oceania, list.len=3 )
str(oceania, list.len=3 , give.attr = F)

##  Cocos Islands has no number, prune to exclude
##  give.attr=F much cleaner w/o attributes
rrapply::rrapply(oceania,
                f = \(x) x,
                classes = "numeric",
                how  = "prune"
) |> str(list.len=3, give.attr=F)

## prune , flatten
rrapply::rrapply(oceania,
                classes = "numeric",
                how  = "flatten"
) |> head(10)

## Beautiful
rrapply::rrapply(oceania,
                classes = "numeric",
                how  = "flatten",
                options = list(namesep=".", simplify = F)

) |> str(list.len=10, give.attr=F)


