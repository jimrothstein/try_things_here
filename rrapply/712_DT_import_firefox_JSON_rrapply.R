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

listviewer::jsonedit(X)

# These are bookmarks I see:  G-mail, NYT ....
# Some are singletons, some are folders
X$children$children[[2]][[2]]
X$children$children[[2]]["uri"]  # only signaltons
# --------------------------------------------------

listviewer::jsonedit(Y)
listviewer::jsonedit(Y[1])


str(Y[2], list.len = 3)
t  <- as_tibble(Y[2])
Y[2]



toolbar = bookmarks[2,]
toolbar
colnames(toolbar)



toolbar$children
toolbar %>% unnest_longer(children)

