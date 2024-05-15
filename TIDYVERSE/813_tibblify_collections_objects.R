# 813_tibblify_collections_objects.R

#       get_spec

#       gh_users_small is example of COLLECTION
#       each element within is OBJECT.

#       See definition of OBJECT (names, etc.)  and must convert to a single ROW.
#       COLLECTION then becomes column

list(1, x=2)  # can not OBJECT, names



# -----------------------
#       SCALAR v VECTOR
# -----------------------

# --------------
##      SCALAR, b/c children are singlular
# --------------
# tib_scalar and its shortcuts, such  as tib_int

z=tibblify(
  list(
    list(id = 1, name = "Peter"),
    list(id = 2, name = "Lilly")
  ),
  tspec_df(
    tib_int("id"),
    tib_chr("name")
  )
)
#       show the spec
get_spec(z)
# tspec_df(
#   tib_int("id"),
#   tib_chr("name"),
# )


x <- list(
  list(id = 1, duration = vctrs::new_duration(100), name="joe"),
  list(id = 2, duration = vctrs::new_duration(200), name="jim")
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

spec = tspec_df(
  tib_int("id"),
  tib_scalar("duration", ptype = vctrs::new_duration()),
  tib_chr("name"),
 )
tibblify(x, spec)


# --------------
#       VECTOR 
# --------------
#  List of 4 elments, each element has variable number of childrne   character vector                                     
x <- list(
  list(id = 1, children = c("Peter", "Lilly")),
  list(id = 2, children = "James"),
  list(id = 3, children = c("Emma", "Noah", "Charlotte"))
)

# guess  (guess "dbl")
get_spec(tibblify(x))

# our best tspec:
spec = tspec_df(
                tib_int("id"),
                tib_chr_vec("children")
                )
tibblify(x,  spec)
identical(tibblify(x), tibblify(x, spec))


# -----------------------
## OBJECT,  children no simple vector, but object
# -----------------------

#  30 elements
gh_repos_small <- purrr::map(gh_repos, ~ .x[c("id", "name", "owner")])
length(gh_repos_small)


# and each has 3 properties, but note owner is list of 17
str(gh_repos_small[[1]], max.level=1)
str(gh_repos_small[[1]]$owner, max.level=1)

# nodify only owner object $object from list of 17 to list of 3
gh_repos_small  <- purrr::map(gh_repos_small,
                              \(repo) {
     repo$owner  <-  repo$owner[c("login", "id", "url")]
    repo})


str(gh_repos_small[[1]]$owner, max.level=1)

# owner now is list of 3
gh_repos_small





