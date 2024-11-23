# 813_tibblify_collections_objects.R


# PURPOSE:   Collections,  Objects, vector,  scalar
# SEE tribblify:  (begin with Objects)   https://mgirlich.github.io/tibblify/


#       gh_users_small is example of COLLECTION
#       each element (row) within is OBJECT.

#       OBJECT (names, etc.)  and must convert to a single ROW.
#       COLLECTION is list of such OBJECTS


# -------
# MUST NAME, RULES
# -------

library(tibblify)
library(vctrs)
library(jsonlite)

# criteria?  error if names are not uniuqe, returns suggested unique names
# vctrs::vec_as_names(names, repair="unique")

vec_as_names(c("a", "a"), repair = "unique")

vec_as_names(c("a", "b"), repair = "unique")

# not a list
L <- c(one = 1, two = 2)
tibblify(L)


# missing name
L <- list(1, two = 2) # can not be OBJECT, missing names
tibblify(L)


## Named,  but  not  correct WHY?
L <- list(one = 1, two = 2)
attributes(L)
z <- tibblify(L)

## This is correct ,  WHY?
L <- list(
  list(one = 1, two = 2)
)

attributes(L)

tibblify(L)



# -----------------------
#       SCALAR v VECTOR
# -----------------------

# --------------
##      SCALAR, b/c children are singlular
# --------------
# tib_scalar and its shortcuts, such  as tib_int

z <- tibblify(
  list(
    list(id = 1, name = "Peter"),
    list(id = 2, name = "Lilly")
  ),
  tspec_df(
    tib_int("id"),
    tib_chr("name")
  )
)
z
# -------
# show the spec
# -------
get_spec(z)
# tspec_df(
#   tib_int("id"),
#   tib_chr("name"),
# )

# -------
# date time (return later)
# -------

x <- list(
  list(id = 1, duration = vctrs::new_duration(100), name = "joe"),
  list(id = 2, duration = vctrs::new_duration(200), name = "jim")
)
x
dput(x)
# list(
# list(id = 1, duration = structure(100, units = "secs", class = "difftime"),
#     name = "joe"),
# list(id = 2, duration = structure(200, units = "secs", class = "difftime"),
#     name = "jim"))

tibblify(x)

# show spec
tibblify::get_spec(tibblify(x))
# tspec_df(
#   tib_dbl("id"),
#   tib_scalar("duration", ptype = vctrs::new_duration()),
#   tib_chr("name"),
# )


# --------------------
# improve its guess?
# --------------------

spec <- tspec_df(
  tib_int("id"),
  tib_scalar("duration", ptype = vctrs::new_duration()),
  tib_chr("name"),
)
tibblify(x, spec)

# -----------------
#  Homogeneous R List of Scalars (are not vectors)  vs Vector of Scalars
# -----------------
# Compare L2 (vector of scalars) and L (list of scalars)
L2 <- list(
  list(a = c(1L, 2L)),
  list(a = c(1L, 2L, 3L))
)
tibblify(L2, tspec_df(tib_int_vec("a")))

x_json <- '[
  {"a": [1, 2]},
  {"a": [1, 2, 3]}
]'

# we get list,  not simple vector, fields are not even named
L <- jsonlite::fromJSON(x_json, simplifyVector = F)
str(L)
dput(L)
list(
  list(a = list(1L, 2L)),
  list(a = list(1L, 2L, 3L))
)

# tell it scalar_list
tibblify(L, tspec_df(tib_int_vec("a", input_form = "scalar_list")))

# --------------
#       another VECTOR  of scalars
# --------------

#  List of 4 elments, each element has variable number of children and 1 or more (not scalar)
x <- list(
  list(id = 1, children = c("Peter", "Lilly")),
  list(id = 2, children = "James"),
  list(id = 3, children = c("Emma", "Noah", "Charlotte"))
)

y <- list(
  list(children = c("Peter", "Lilly")),
  list(children = "James"),
  list(children = c("Emma", "Noah", "Charlotte"))
)

# guess  (guess "dbl")
get_spec(tibblify(x))

# our best tspec: column for "children"  becomes list-column
spec <- tspec_df(
  tib_int("id"),
  tib_chr_vec("children")
)

tibblify(x, spec)

# int v dbl
identical(tibblify(x), tibblify(x, spec))

# ----------
# CONVERT single OBJECT
# ----------
# row vs tibble?

api_output <- list(
  status = "success",
  requested_at = "2021-10-26 09:17:12",
  data = list(
    list(x = 1),
    list(x = 2)
  )
)

# one row tibble
spec_row <- tspec_row(
  status = tib_chr("status"),
  requested_at = tib_chr_date("requested_at"),
  tib_df(
    "data",
    tib_int("x")
  )
)
# list of tibbles column (!)
tibblify(api_output, spec_row)


# -----------------------
## OBJECT,  children not simple vector, but object
#  Recall object can be converted to row in a tibble
# -----------------------

#  30 elements in LIST
gh_repos_small <- purrr::map(gh_repos, ~ .x[c("id", "name", "owner")])
length(gh_repos_small)
head(gh_repos_small)


# and each has 3 properties, but note owner is list of 17
str(gh_repos_small[[1]], max.level = 1)

str(gh_repos_small[[1]]$owner, max.level = 1)

# Each element (of 30)  looks like:
#   owner  is OBJECT, a  list that could become its own tibble

# list(
#   id= 611,
#   name = "after",
#   owner = list(  .... 17)
# )


# nodify only owner object $object from list of 17 to list of 3
gh_repos_small <- purrr::map(
  gh_repos_small,
  \(repo) {
    repo$owner <- repo$owner[c("login", "id", "url")]
    repo
  }
)


str(gh_repos_small[[1]]$owner, max.level = 1)

# owner now is list of 3
gh_repos_small





#  -----------------------------
#  List of Tibbles/data.frames
#  -----------------------------

L <- list(
  list(id = 1, data = mtcars[1, ]),
  list(id = 2, data = mtcars[3, ]),
  list(id = 3, data = NULL),
  #    list(id=4, data=data.frame()),   # error
  list(id = 4, data = list())
)

spec <- tspec_df(
  tib_dbl("id"),
  tib_df(
    "data",
    tib_dbl("mpg", required = F),
    .required = F
  )
)

tibblify(L, spec)
