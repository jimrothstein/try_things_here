## 225_tidyr_unravel_Github_Users.R
# TAGS:  tidry, unnest_wider

# REF https://tidyr.tidyverse.org/articles/rectangle.html
# Rectangling, from tidyr vignette
# TODO 2024-03-21
# - streamline !


library(tidyr)
library(dplyr)
library(repurrrsive)



users <- tibble(user = gh_users)
dim(users) # [1] 6 1
head(users)
# # A tibble: 6 × 1
#   user
#   <list>
# 1 <named list [30]>
# 2 <named list [30]>
# 3 <named list [30]>
# 4 <named list [30]>
# 5 <named list [30]>
# 6 <named list [30]>


# Use enframe, rather than older approach in  vignette
users <- tibble::enframe(gh_users)
head(users)
tibble::is_tibble(users) # Note

# -------------------------
# PROBE, wider or longer?
# -------------------------

# By eye, each element is named,  simple 1-level list
str(users$value[[1]])


# All elements named? yes
all(rlang::is_named(users$value[[1]])) # [1] TRUE

# check all rows (6)
sapply(users$value, is_named) # [1] TRUE TRUE TRUE TRUE TRUE TRUE
# Are all the names the SAME?
sapply(users$value, names)
z <- lapply(users$value, function(e) list(names(e)))

length(z) # [1] 6
# naems are same? yes
setdiff(
        z[[1]],
        z[[2]]
)

# NOTE:  `name` appears TWICE
names(users)
names(users$value[[1]])
attributes(users)
intersect(names(users), names(users$value[[1]]))

users <- setNames(users, c("ID", "value"))
#       try wider
users |> tidyr::unnest_wider(value)


# -------------
#       aside
# -------------
str(users$values[[1]], max.depth = 1)
sapply(users$values, function(e) e[[1]])
z <- lapply(users$values, function(e) names(e))
z1 <- lapply(z, rbind)
rbind(z1)
z1
as_tibble(z1)
