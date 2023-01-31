library(data.table)
library(rrapply)
library(jsonlite)
library(listviewer)
library(tibble)


the_dir  <- "~/Downloads/to_Drive"
the_dir
the_file  <- paste0(the_dir, "/", "bookmarks-2023-01-22.json")

the_file

X <- jsonlite::fromJSON(the_file, 
    simplifyVector = T, 
    simplifyDataFrame = T, flatten=T)


bookmarks =  as_tibble(X)
bookmarks
toolbar = bookmarks[2,]
toolbar
colnames(toolbar)



toolbar$children
toolbar %>% unnest_longer(children)

