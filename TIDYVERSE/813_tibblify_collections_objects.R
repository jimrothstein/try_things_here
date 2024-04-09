813_tibblify_collections_objects.R

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
##      SCALAR
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
x <- list(
  list(id = 1, children = c("Peter", "Lilly")),
  list(id = 2, children = "James"),
  list(id = 3, children = c("Emma", "Noah", "Charlotte"))
)

# guess  (guess "dbl")
get_spec(tibblify(x))

spec = tspec_df(
                tib_int("id"),
                tib_chr_vec("children")
                )
tibblify(x,  spec)
identical(tibblify(x), tibblify(x, spec))
