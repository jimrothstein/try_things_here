#
##  Compare to base::rapply
##

library(tibble)
library(jsonlite)
library(dplyr)
library(listviewer)
library(tidyr)

get_file <- function() {
    the_dir <- "~/code/try_things_here/rrapply/bookmarks"
    the_file <- paste0(the_dir, "/", "bookmarks-2023-05-24_FF.json")
}
the_file <- get_file()

##  no attempt to simplify
##  x is a list of lists
x <- jsonlite::read_json(the_file)
listviewer::jsonedit(x)
listviewer::jsonedit(x$children)
#

x1 <- x$children %>% tibble()
jsonedit(x1)


##  named list of 10,   4 rows
x1


names(x1) <- "first"
x2 <- x1$first %>% tibble()

x3 <- x2 %>% hoist(".",
    title = "title",
    children = "children"
)


x4 <- x3 %>% unnest_longer("children")
unique(x4$title)

x5 <- x4 %>% hoist("children",
    uri = "uri",
    title1 = "title"
)


x5 %>% select(c("title", "uri", "title1"))
x5 %>% select(c("title1"))
