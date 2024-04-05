# 06_02_primitive_functions.R

# ------------------------------------------------
# 		Primitive or special functions are C, not R,
# 		NO  formals(), body() or environment()
# ------------------------------------------------
sum
# function (..., na.rm = FALSE)  .Primitive("sum")
`[`
# .Primitive("[")



# ----------------------------
# 	No formals,environment etc
# ----------------------------
sapply(list(sum, `[`), formals)
# [[1]]
# NULL
#
# [[2]]
# NULL

sapply(list(sum, `[`), environment)
# [[1]]
# NULL
#
# [[2]]
# NULL


# -------------------
# builin or special
# -------------------
typeof(sum)
# [1] "builtin"

typeof(`[`)
# [1] "special"
