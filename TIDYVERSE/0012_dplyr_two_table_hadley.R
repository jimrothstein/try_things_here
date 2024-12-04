# 012_dplyr_two_table_hadley.R

# see:
#   http://dplyr.tidyverse.org/articles/two-table.html

# Tags:   left_join(), inner_join(), knitr
library(tidyverse)
library(nycflights13)
library(knitr)

# ---- natural join  (common fields) -------------
flights %>% left_join(weather) # 336,776 x 28

# ---- by=  (limits fields)------
str(flights)
str(planes) # year means manu year
flights %>% left_join(planes, by = "tailnum") # 336,776 x 27

# ---- by=   (specific values)

# ---- inner_join ------------
df1 <- data_frame(
  x = c(1, 2), # NOT data.frame
  y = 2:1
)
df1

df2 <- data_frame(
  x = c(1, 3),
  a = 10,
  b = "a"
)
df2

inner_join(df1, df2)
inner_join(df1, df2) %>% knitr::kable() # nice printing

# ---- CARTESIAN, left_join(), non-unique

df1 <- data_frame(
  x = c(1, 1, 2),
  y = c(1, 2, 3)
)

df2 <- data_frame(
  x = c(1, 1, 2),
  z = c("a", "b", "c")
)

# specify "x"
df1 %>% left_join(df2, by = "x") # get all possible


# ---- semi_join(), anti_join() ----------

# flights with NO matching plane
flights %>% anti_join(planes, by = "tailnum") %>% # many
  dplyr::count(tailnum, sort = TRUE)


# anther way:
flights %>%
  anti_join(planes, by = "tailnum") %>% # many
  group_by(tailnum) %>%
  summarize(count = n()) %>%
  arrange(desc(count))

# ---- study, WHEN needed ----------
# MORE examples

band_members
band_instruments

band_members %>% inner_join(band_instruments)
band_members %>% left_join(band_instruments)
band_members %>% right_join(band_instruments)
band_members %>% full_join(band_instruments)

# To suppress the message about joining variables, supply `by`
band_members %>% inner_join(band_instruments, by = join_by(name))
# This is good practice in production code

# Use an equality expression if the join variables have different names
band_members %>% full_join(band_instruments2, by = join_by(name == artist))
# By default, the join keys from `x` and `y` are coalesced in the output; use
# `keep = TRUE` to keep the join keys from both `x` and `y`
band_members %>%
  full_join(band_instruments2, by = join_by(name == artist), keep = TRUE)

# If a row in `x` matches multiple rows in `y`, all the rows in `y` will be
# returned once for each matching row in `x`.
df1 <- tibble(x = 1:3)
df2 <- tibble(x = c(1, 1, 2), y = c("first", "second", "third"))
df1 %>% left_join(df2)

# If a row in `y` also matches multiple rows in `x`, this is known as a
# many-to-many relationship, which is typically a result of an improperly
# specified join or some kind of messy data. In this case, a warning is
# thrown by default:
df3 <- tibble(x = c(1, 1, 1, 3))
df3 %>% left_join(df2)

# In the rare case where a many-to-many relationship is expected, set
# `relationship = "many-to-many"` to silence this warning
df3 %>% left_join(df2, relationship = "many-to-many")

# Use `join_by()` with a condition other than `==` to perform an inequality
# join. Here we match on every instance where `df1$x > df2$x`.
df1 %>% left_join(df2, join_by(x > x))

## NA matches NA !
# By default, NAs match other NAs so that there are two
# rows in the output of this join:
df1 <- data.frame(x = c(1, NA), y = 2)
df2 <- data.frame(x = c(1, NA), z = 3)
left_join(df1, df2)

# You can optionally request that NAs don't match, giving a
# a result that more closely resembles SQL joins
left_join(df1, df2, na_matches = "never")
