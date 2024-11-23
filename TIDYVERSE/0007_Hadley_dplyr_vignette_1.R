# 007_Hadley_dplyr_vignette.R


# 00-Info -----------------------------------------------------------------
## Follows BASIC dplyr operations
# see: http://dplyr.tidyverse.org/articles/dplyr.html



# 01-Setup ----------------------------------------------------------------
library(tidyverse)
library(nycflights13)


# 02-Quick Look -----------------------------------------------------------
dim(flights) # 336776 x 19
flights %>% glimpse()

# 03-summarize() -------------------------------------------------------------
# part2 - summerize details

# TIP:    ask  KEEPS, ADDS, DROPS ..

# for each plane.
by_tailnum <- flights %>% group_by(tailnum)
delay <- by_tailnum %>% summarise( # 4044 x 4
  count = n(),
  dist = mean(distance, na.rm = TRUE),
  delay = mean(arr_delay, na.rm = TRUE)
)

# 04-arrange --------------------------------------------------------------

## reorders the columns, rows ordered by 1st field
sorted_flights <- flights %>% arrange(year, month, day) # show how 'arranged'?
attributes(sorted_flights)

tail(flights)
tail(sorted_flights)

# 04A-arrange: helper functions -------------------------------------------

flights %>% base::colnames()
flights %>%
  select(year, month, day) %>%
  arrange(year, desc(month), day) %>%
  filter(day == 2)

# 05-group_by() -------------------
# KEEPS group_by variables

# repeat 1st exmample
by_tailnum <- flights %>% group_by(tailnum)
delay <- by_tailnum %>% summarise( # 4044 x 4
  count = n(),
  dist = mean(distance, na.rm = TRUE),
  delay = mean(arr_delay, na.rm = TRUE)
)

# 06-filter() -------------------------------------------------------------
delay <- filter(delay, count > 20, dist < 2000)
dim(delay) # 2962 x 4

# compare dist and delay
delay %>% ggplot(aes(dist, delay)) +
  geom_point()

# fancy way, warning?
delay %>% ggplot(aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 0.5) +
  geom_smooth() +
  scale_size_area()


# 05A-group_by: info ------------------------------------------------------
by_tailnum <- flights %>% dplyr::group_by(tailnum)

by_tailnum %>% dplyr::is.grouped_df() # TRUE
by_tailnum %>% dplyr::is_grouped_df() # TRUE
by_tailnum %>% dplyr::group_vars() # chr vector "tailnum"
by_tailnum %>% dplyr::groups() # list: [[1]] tailnum

# 06A-dplyr::distinct() -----
## distinct() takes tibble, field --> rows (not number)
flights %>% distinct(dest) # 105 x 1
flights %>%
  distinct(dest) %>%
  arrange(dest) # alpha order

# next, returns columns 8, 1, 3 control by select;
# Note: .keep_all
flights %>%
  distinct(dest, .keep_all = TRUE) %>%
  select(c(8, 1, 3)) %>%
  head()

# .keep_all default=FAlse
flights %>%
  distinct(dest, .keep_all = TRUE) %>%
  head() # keeps all fields
flights %>%
  distinct(dest) %>%
  head() # returns only 1 field

# 06B-n_distinct() --------------------------------------------------------

## n_distinct() takes vector NOT tibble, returns number
a <- c(1, 3, 1, 2, 1, 1, 5)
dplyr::n_distinct(a) # 4

flights %>% n_distinct(dest) # ERROR
n_distinct(flights, dest) # ERROR

# ---- select_if()
flights %>% select_if("dest" == "BAL")

colnames(flights)

# ---- unique, n_distinct (returns number)
flights %>%
  group_by(tailnum) %>%
  summarise(distinct = n_distinct(dest)) %>%
  arrange(desc(distinct))
flights %>%
  group_by(dest) %>%
  summarize(
    planes = n_distinct(tailnum),
    flights = n()
  ) %>%
  arrange(desc(flights))



# 07-Select() -------------------------------------------------------------

## many options; DROPS fields not mentioned
## Therefore, usually used with group_by()


## NOTE:  see part 2 for ways to select variables
select(flights, year, month, day)

select(flights, year:day) # inclusive

select(flights, -(year:day)) # exclude

# many helpers
select(flights, starts_with("tail"))

# can rename a field, but usually better to use rename()
select(flights, tail_num = tailnum) # drops other fields
rename(flights, tail_num = tailnum) # renames AND keeps all fields

# want select to sort by group_by() ?   ADD .by_group=TRUE

# 08-mutate() -------------------------------------------------------------

# compare
select(flights, "year", 2) %>% head(3) # ADDS 2 columns
mutate(flights, "year", 2) %>% glimpse() # ADDS 2 columns as fixed content!

# nice trick:
var <- seq(1, nrow(flights))
mutate(flights, new = var) %>% glimpse()
# ## STOP - basic dplyr ---------------------------------------------------

##
# ---- left_join()
flights2 <- flights %>% left_join(airlines) # figures out by 'carrier'
flights3 <- flights %>% left_join(airlines, by = "carrier") # same result


colnames(flights)
# [1] "year"           "month"          "day"            "dep_time"
# [5] "sched_dep_time" "dep_delay"      "arr_time"       "sched_arr_time"
# [9] "arr_delay"      "carrier"        "flight"         "tailnum"
# [13] "origin"         "dest"           "air_time"       "distance"
# [17] "hour"           "minute"         "time_hour"
# >


colnames(flights2)


# 1] "year"           "month"          "day"            "dep_time"
# [5] "sched_dep_time" "dep_delay"      "arr_time"       "sched_arr_time"
# [9] "arr_delay"      "carrier"        "flight"         "tailnum"
# [13] "origin"         "dest"           "air_time"       "distance"
# [17] "hour"           "minute"         "time_hour"      "name"
# >

head(flights2 %>% select(tailnum, carrier, name))
