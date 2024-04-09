75_tibblify_bookmarks.R

# TODO
2024-04-08
- work on  tspec ... choking on initial levels of bookmarks

library(tibblify)
library(jsonlite)

the_file <- "~/code/try_things_here/rrapply/bookmarks/bookmarks-2023-05-24_FF.json"
x <- jsonlite::read_json(path = the_file)


t <- tibblify(x)
t
if (F) { # Mess !
  tibblify::get_spec(t)
}

# --------------
# Improve spec
# --------------
spec <- tibblify::tspec_recursive(
  tib_chr("root"),
  tib_chr("guid"),
  tib_chr("title"),
  tib_chr("uri", required = FALSE),
  .children = "children"
)
z=x$children[[1]]$children[[1]]
t2 <- tibblify::tibblify(z, spec)
x[[1]]
x[[2]]
names(x)
x[[9]]
