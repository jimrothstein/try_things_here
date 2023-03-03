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



the_dir  <- "./data"
# the_dir
the_file  <- paste0(the_dir, "/", "bookmarks-2023-03-01.json")

the_file

##  no attempt to simplify
##  x is a list of lists
x  <- jsonlite::read_json(the_file)
#
listviewer::jsonedit(x)


menu  <- x$children[[1]]    # has   89 children, menu has length 10
toolbar <- x$children[[2]]  # has 16 children
jsonedit(menu)
str(menu, list.len=3)
str(menu, list.len=10)

str(menu$children[[1]], list.len=11, max.level=2)
str(menu$children[[1]], list.len=11, max.level=3)

# ----------------------------------------------------------
menu_melt <- rrapply(
    menu,
    condition = function(x, .xname) .xname %in% c("title", "uri"),
    classes = "character",
    how = "melt"
  ) 
menu_melt
as_tibble(menu_melt)
# ----------------------------------------------------------

head(z, n=20)

y  <- rrapply(menu, 
  classes="character",
  how="prune",
  )
y

##  many cols 
y  <- rrapply(menu, 
  how="bind"
  )

## y is 1 x 926 
y  <- rrapply(menu, 
  how="bind", 
  options = list(namecols=T),  
  )


y  <- rrapply(menu, 
  how="flatten")

str(y, list.len=5)


rrapply(menu$children[1], how = "bind")[, c("title", "uri")] |> head(n = 10)
rrapply(menu$children[1], how = "bind")[, c("title", "uri")] |> head(n = 10)



rrapply(menu,
  f = \(x) names(x) != "uri",
  how="prune"
)
