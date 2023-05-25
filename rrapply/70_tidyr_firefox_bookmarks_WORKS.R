#
#  0430_tidyr_firefox_bookmarks_WORKS.R
##  Compare to base::rapply
##

library(tibble)
library(jsonlite)
library(dplyr)
library(listviewer)
library(tidyr)


the_dir  <- "~/Downloads/to_Drive"
the_dir
the_file  <- paste0(the_dir, "/", "bookmarks-2023-01-22.json")

the_file

##  no attempt to simplify
##  x is a list of lists
x  <- jsonlite::read_json(the_file)
#
listviewer::jsonedit(x)
listviewer::jsonedit(x$children)

x1  <- x$children %>% tibble()
jsonedit(x1)


##  4 x 1 tibble, each cell: named list of 10 ellements
x1


names(x1)  <- "first"
x2  <- x1$first  %>% tibble()

x2
x3  <- x2 %>% hoist(".", 
  title = "title",
  children = "children"
  )
x3


x4  <- x3 %>% unnest_longer("children")
x4

names(x4)
unique(x4$title)

x5  <- x4 %>% hoist("children",
      uri = "uri",
      title1 = "title"
)


x5 %>% dplyr::select(c("title", "uri", "title1"))
x5 %>% select(c("title1"))

