# 810_tibblify_examples.R
library(tibblify)
library(constructive)

# Examples:

x =  list(
    a=list(id = 1, name ="one"),
    b=list(id= 2,name="two")
    )

y =  list(
    list(id = 1, name ="one"),
    list(id= 2,name="two")
    )

# -------------------------
# 2) Provide a specification
# -------------------------
spec <- tspec_df(
        id = tib_int("id"),
        name = tib_chr("name")
)

## But ...too simple returns list, not tibble
tibblify(x, spec)

# $a
# [1] 1
# 
# $b
# [1] 2

# ---------------------
##      tibble, 1 row
# ---------------------
z=tibblify(list(
              list(id=1, name="A")), spec); z

+ # A tibble: 1 × 2
     id name 
  <int> <chr>
1     1 A    
# ----------------------------
##      compare spec 2 ways:
##      from tibblify::get_spec()
##      from constructive::construct()
# ----------------------------
##      
construct(z)
tibblify::get_spec(z)

# --------------------------
##      tibble with 2 rows
# --------------------------
z=tibblify(list(
              list(id=1, name="A"),
              list(id=2, name="B"))
)
z

# # A tibble: 2 × 2
#      id name 
#   <dbl> <chr>
# 1     1 A    
# 2     2 B    

construct(z)
get_spec(z)


# ---------------
## more complex
# ---------------
## tibblify(L) won't work (not object, not list of objects)
L=list(
                list(level="A", 
                     list(level="B", month="APR", 
                          data=
                                     list(
                                          list(id=1, value=1),
                                          list(id=2, value=2),
                                          list(id=3, value=3),
                                          list(id=4, value=4)
                                          )
                          )
                     )
                )
z=enframe(L)
str(z)
tidyr::unnest_wider(z,value)
str(z$value)

# ----------------------------
# 3) fails with using functions
# ----------------------------
x <- list(
        list(sin, cos),
        list(tan, cos)
)
tibblify(x)

# ------------------------------
#  4) Very different from tibble
# ------------------------------
identical(tibble(mtcars), tibblify(mtcars))
attributes(tibblify(mtcars))

# ---------------------------------------------
# Provide a specification for a single object
#       not what I expected
# ---------------------------------------------
tibblify(x[[1]], tspec_object(spec))
# $id
# [1] 1
#
# $name
# [1] "Tyrion Lannister"
x[[1]]

# -----------------------------------------------------------------------------
# Recursive Trees -----------------------------------------------------------
#       produces tibble with colunn of nested tibbles
# -----------------------------------------------------------------------------
x <- list(
        list(
                id = 1,
                name = "a",
                kids = list(
                        list(id = 11, name = "aa"),
                        list(
                                id = 12, name = "ab",
                                kids = list(
                                        list(id = 121, name = "aba")
                                )
                        )
                )
        )
)
## it tries, can do better
tibble(x)

dput(x)
# list(list(id = 1, name = "a", children = list(list(id = 11, name = "aa"),
#     list(id = 12, name = "ab", children = list(list(id = 121,
#         name = "aba"))))))
#
#
#
#
spec <- tspec_recursive(
        tib_int("id"),
        tib_chr("name"),
        .children = "kids" # name of field holding children
)

out <- tibblify(x, spec); out

out$kids
out$kids[[1]]
out$kids[[1]]$kids[[2]]

### tibblify list that contains a data.frame?   Do  in REVERSE...

                                        # first,  result should  be:
tbl =  tibble(id=c(1,2),
       data=list(mtcars[1,],  mtcars[3,]))
dput(tbl)

# get the spec
spec = tibblify::guess_tspec_df(tbl);  spec

tibblify(dput(tbl), spec)
tibblify(tbl, spec)


#  NOw,  create a list
L=list(id=c(1,2),
       data=list(mtcars[1,],mtcars[3,]))

spec = tspec_df(
    tib_dbl("id"),
    tib_df(
        "data",
        tib_dbl("mpg")
        )
    )
                                        # Not quite!
tibblify(L, spec)

L = list(
    a=list(line=1, df=mtcars),
    b=list(line=2, df=mtcars)
    )





