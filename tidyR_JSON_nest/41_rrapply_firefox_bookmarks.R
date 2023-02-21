#
##  Compare to base::rapply
##
library(rrapply)
library(listviewer)
data(package = "rrapply")


##  give.attr=F (cleaner):w
##  list.len=3
##  max.level = 
str(renewable_energy_by_country$World$Oceania, list.len=3, give.attr = F)



the_dir  <- "~/Downloads/to_Drive"
the_dir
the_file  <- paste0(the_dir, "/", "bookmarks-2023-01-22.json")

the_file

##  no attempt to simplify
##  x is a list of lists
x  <- jsonlite::read_json(the_file)
#
listviewer::jsonedit(x)


menu  <- x$children[[1]]
str(menu, list.len=3)

head(menu, 10)
str(menu, list.len=10)

str(menu$children[[1]], list.len=4, max.level=6)

rrapply(menu, 
  f = \(x) names(x) == "uri",  
  how="bind")[, c(2,9)] |> head(n=10)

rrapply(menu$children[1], how = "bind")[, c(2, 9)] |> head(n = 10)



rrapply(menu,
  f = \(x) names(x) != "uri",
  how="prune"
)
