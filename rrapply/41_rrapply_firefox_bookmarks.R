#
##  Compare to base::rapply
##
library(rrapply)
library(listviewer)
data(package = "rrapply")


##  give.attr=F (cleaner):w
##  list.len=3
##  max.level = 


# ----------------------------------------------------------
the_dir  <- "./data"
# the_dir
the_file  <- paste0(the_dir, "/", "bookmarks-2023-03-01.json")
the_file


##  no attempt to simplify
##  x is a list of lists
x  <- jsonlite::read_json(the_file)
#
listviewer::jsonedit(x)
# ------------------------menu----------------------------------


menu  <- x$children[[1]]    # has   89 children, menu has length 10
toolbar <- x$children[[2]]  # has 16 children
jsonedit(menu)
str(menu, list.len=3)
str(menu, list.len=10)

str(menu$children[[1]], list.len=11, max.level=2)
str(menu$children[[1]], list.len=11, max.level=3)
one  <- as_tibble(menu)[9:10]
one
two  <- tidyr::unnest_wider(one, "children")[, c(1,2,3,7,9,10,11)][c("title", "tags",  "uri")]
two

# -------------------- Toolbar--------------------------------------
toolbar <- x$children[[2]]  # has 16 children
toolbar
one  <- as_tibble(toolbar)[9:10]
one

two  <- tidyr::unnest_wider(one, "children")[, c(1,2,3,12,13)]


# ---------------------------- toolbar_wider------------------------------
toolbar_wider  <- tidyr::unnest_wider(one, "children")[, c(1,2,3,12,13)]
dim(toolbar_wider) # 16 x 5 

# separate uri from no uri?
toolbar_wider|> head(10)
# # A tibble: 10 × 5
#    root          guid         title        uri                     child…¹
#    <chr>         <chr>        <chr>        <chr>                   <list> 
#  1 toolbarFolder JiBFMXomg70m "G-mail"     https://mail.google.co… <NULL> 
#  2 toolbarFolder qqsDDO3ugt5F "NYT"        https://www.nytimes.co… <NULL> 
#  3 toolbarFolder xeekRq9oQoxt "Voice - "   https://voice.google.c… <NULL> 
#  4 toolbarFolder 0b4c1EWaJmuY "G-"         <NA>                    <list> 
#  5 toolbarFolder OjehAeYSTSJx "news_sites" <NA>                    <list> 
#  6 toolbarFolder anVoXRj0xB5e "MyTech"     <NA>                    <list> 
#  7 toolbarFolder j-xSaLr7mNGD "myStuff"    <NA>                    <list> 
#  8 toolbarFolder QqaOw7z782RG "listen"     <NA>                    <list> 
#  9 toolbarFolder qXSS1Pkbg-nl "*health"    <NA>                    <list> 
# 10 toolbarFolder fTWvsNLN3wM3 "*Cheat"     <NA>                    <list> 
# # … with abbreviated variable name ¹​children

##  only !is.na(uri)
toolbar_wider$uri[!is.na(toolbar_wider$uri)]
toolbar_wider[!is.na(toolbar_wider$uri), ]
toolbar_wider[is.na(toolbar_wider$uri), ]

## 
z  <- unnest_longer(toolbar_wider, children)
unnest_longer(z, children)
unnest_longer(z, children)$children[[1]]
# # A tibble: 10,668 × 6
#    root          guid         title uri   children     children_id 
#    <chr>         <chr>        <chr> <chr> <named list> <chr>       
#  1 toolbarFolder 0b4c1EWaJmuY G-    <NA>  <chr [1]>    guid        
#  2 toolbarFolder 0b4c1EWaJmuY G-    <NA>  <chr [1]>    title       
#  3 toolbarFolder 0b4c1EWaJmuY G-    <NA>  <int [1]>    index       
#  4 toolbarFolder 0b4c1EWaJmuY G-    <NA>  <dbl [1]>    dateAdded   
#  5 toolbarFolder 0b4c1EWaJmuY G-    <NA>  <dbl [1]>    lastModified
#  6 toolbarFolder 0b4c1EWaJmuY G-    <NA>  <int [1]>    id          
#  7 toolbarFolder 0b4c1EWaJmuY G-    <NA>  <int [1]>    typeCode    
#  8 toolbarFolder 0b4c1EWaJmuY G-    <NA>  <chr [1]>    type        
#  9 toolbarFolder 0b4c1EWaJmuY G-    <NA>  <chr [1]>    uri         
# 10 toolbarFolder 0b4c1EWaJmuY G-    <NA>  <chr [1]>    guid        
# # … with 10,658 more rows
# # ℹ Use `print(n = ...)` to see more rows
#
unnest_wider(unnest_longer(z,children), children)
# ----------------------------------------------------------



tidyr::unnest_wider(two, "children", names_sep="*")  # complains some lists have no names

OR

##  too wide !
three  <- rrapply(two, how="bind", options=list(namecols=T))
dim(three)  
# [1]     1 41622
names(three)[1:30]

## no benefit of coldepth
three  <- rrapply(two, how="bind", options=list(namecols=T, coldepth=2))
str(three, list.len=3)    # 1 x 41622
as_tibble(three)   # 1 x 41,622



##   return only list names containing "uri", get named list() empty

x=c("uriance", "joke")
x[grep(x, pattern="uri", ignore.case=T)]


head(toolbar)
rrapply(toolbar, condition = \(x) x %in% c("uri"), how="prune")
rrapply(toolbar, condition = \(x, .xname) x[grep(.xname, pattern="uri")], how="prune")
rrapply(two, 


# ---------------------------- toolbar_melt ------------------------------
toolbar_melt <- rrapply(
    toolbar,
    condition = function(x, .xname) .xname %in% c("title", "uri"),
    classes = "character",
    how = "melt"
  ) 
toolbar_melt
as_tibble(toolbar_melt)
as_tibble(toolbar_melt)[, c(1,3,14)]


# ---------------------------MENU v 2-------------------------------
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
