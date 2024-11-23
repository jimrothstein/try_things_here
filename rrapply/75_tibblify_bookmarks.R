75_tibblify_bookmarks.R

# TODO
2024-04-08
- work on  tspec ... choking on initial levels of bookmarks

library(tibblify)
library(jsonlite)

the_file <- "~/code/try_things_here/rrapply/bookmarks/bookmarks-2023-05-24_FF.json"
bookmarks <- jsonlite::read_json(path = the_file)

# 1 of 4
menu <- bookmarks$children[[1]]
names(menu)

# data
length(menu$children) # [1] 87
names(menu$children)

#works
z=tibblify(bookmarks$children[[1]]$children)
get_spec(tibblify(bookmarks$children[[1]]$children))
head(z)
z |> select("guid", "title", "index", "id", "typeCode", "type")
z |> select("title", "index",   "type")
z |> select("title", "index",  "uri") 
z |> select("title", "children", "typeCode") |> dplyr::filter(typeCode == 2)

# ---------
## chokes
# ---------
t <- tibblify(x)
t
if (F) { # Mess !
  tibblify::get_spec(t)
}


# --------------
# Improve spec
# --------------
spec <- tibblify::tspec_recursive(
  tib_chr("root", required=FALSE),
  tib_chr("guid"),
  tib_chr("title"),
  tib_int("typeCode"),
  tib_chr("uri", required = FALSE),
  )
tibblify(bookmarks$children[[1]]$children)

# ---------
## chokes
# ---------
t <- tibblify(x)
t
if (F) { # Mess !
  tibblify::get_spec(t)
}


# --------------
# ---------
## chokes
# ---------
t <- tibblify(x)
t
if (F) { # Mess !
  tibblify::get_spec(t)
}


# --------------
# Improve spec
# --------------
spec <- tibblify::tspec_recursive(
  tib_chr("root", required=FALSE),
  tib_chr("guid"),
  tib_chr("title"),
  tib_int("typeCode"),
  tib_chr("uri", required = FALSE),
  .children = "children"
)
z=x$children[[1]]$children
t2 <- tibblify::tibblify(z, spec)
t2[, c(2,3,4,5)]
