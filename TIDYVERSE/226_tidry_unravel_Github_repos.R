repos <- tibble(repo = gh_repos)
# TAGS:  tidry, unnest_wider

# REF https://tidyr.tidyverse.org/articles/rectangle.html
# Rectangling, from tidyr vignette
# TODO 2024-03-21
# - streamline !


library(tidyr)
library(dplyr)
library(repurrrsive)



# Use enframe, rather than older approach in  vignette
repos <- tibble::enframe(gh_repos)
head(repos)
tibble::is_tibble(repos) # Note

# -------------------------
# PROBE, wider or longer?
# -------------------------

# By eye, each element is named,  simple 1-level list
str(repos$value[[1]], max.level = 1)


# All elements named? NO
all(rlang::is_named(repos$value[[1]])) # [1] F
names(repos$value[[1]]) # NULL
length(repos$value[[1]]) # [1] 30

# ----------------------
#       suspect longer
# ----------------------
names(repos)
z1 <- repos |> tidyr::unnest_longer(value)
z1
is_tibble(z1)
str(z1, max.level = 1)
dim(z1) # [1] 176   2


#
# -------------------------------
#       Probe 166 rows of value
# -------------------------------
# all named?
rlang::is_named(z1$value[[1]])
# [1] TRUE
rlang::have_name(z1$value[[1]])
#  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
# [23] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
# [45] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
# [67] TRUE TRUE
all(rlang::have_name(z1$value[[1]]))


# --------------------------------
# suspect z1$value each is named
# --------------------------------
# names found in multiple levele
z1 <- setNames(z1, c("ID", "value"))
names(z1)

z2 <- z1 |> tidyr::unnest_wider(value)
dim(z2) # [1] 176  69
z2[1, ]
vctrs::vec_ptype_show(z2[1, ])
