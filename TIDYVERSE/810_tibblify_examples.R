810_tibblify_examples.R
library(tibblify)

# Examples:

# -----------------------------------------------------------------------------
# 1) List of Objects -----------------------------------------------------------
# -----------------------------------------------------------------------------
x <- list(
        list(id = 1, name = "Tyrion Lannister"),
        list(id = 2, name = "Victarion Greyjoy")
)
tibblify(x)

# -------------------------
# 2) Provide a specification
# -------------------------
spec <- tspec_df(
        id = tib_int("id"),
        name = tib_chr("name")
)
tibblify(x, spec)



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

out <- tibblify(x, spec)
out

out$kids
out$kids[[1]]
out$kids[[1]]$kids[[2]]

###
