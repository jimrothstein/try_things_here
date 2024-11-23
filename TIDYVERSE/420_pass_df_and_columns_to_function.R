# 420_pass_df_and_columns_to_function.R
#       TAGS: env_var, data_var

# PURPOSE:      Clarify use of env_var, data_var  when passing both df and column to a function

# ----------------------------------------------
##      Add new column, based on column passed
# ----------------------------------------------
test_function <- function(data, my_col) {
  return(data %>% mutate(
    {{ my_col }} := 5
  ))
}

identical( # TRUE
  test_function(mtcars, "new_column"),
  test_function(mtcars, new_column)
)



# --------------------
#       Pass env_var
# --------------------
test_function1 <- function(data, col) {
  `[[`(data, {{ col }})
}


z <- "hp"
test_function1(mtcars, z)
