library(data.table)
library(rrapply)
library(jsonlite)
library(listviewer)
library(tibble)


the_dir  <- "~/Downloads/to_Drive"
the_dir
the_file  <- paste0(the_dir, "/", "bookmarks-2023-01-22.json")

the_file

##  
bookmarks  <- read_json(the_file)



# -------------------------------------
##  object > list > tibble always works?
##
##
bookmarks  <- bookmarks$children
  x1  <- bookmarks %>% list()
x1
  x2   <- x1 %>% tibble()
x2 # 1x1
x3  <- x2 %>%  unnest_longer(col = 1)
x3
# -------------------------------------
##
##
##
##
##
##
z  <- as_tibble(bookmarks)
z$children[[2]]
dim(z$children)
str(z$children, list.len=3)

toolbar  <- z$children[[2]]
str(toolbar, list.len=3)
str(toolbar, list.len=9)
str(toolbar, list.len=10, max.level=2)

## must be tibble 
X  <- as_tibble(toolbar) %>% unnest_longer(children)

colnames(X)

X$children
