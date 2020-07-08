# 012_dplyr_two_table_hadley.R

# see:
#   http://dplyr.tidyverse.org/articles/two-table.html

# Tags:   left_join(), inner_join(), knitr
library(tidyverse)
library(nycflights13)
library(knitr)

# ---- natural join  (common fields) -------------
flights %>% left_join(weather)  # 336,776 x 28

# ---- by=  (limits fields)------
str(flights)
str(planes)   # year means manu year
flights %>% left_join(planes, by="tailnum")  # 336,776 x 27

# ---- by=   (specific values)

# ---- inner_join ------------
df1 <- data_frame(x = c(1,2),    # NOT data.frame
                  y = 2:1)
df1

df2 <- data_frame(x = c(1,3),
                  a = 10,
                  b = "a")
df2

inner_join(df1,df2)
inner_join(df1, df2) %>% knitr::kable()   # nice printing

# ---- CARTESIAN, left_join(), non-unique

df1 <- data_frame(x = c(1,1,2),
                  y = c(1,2,3))

df2 <- data_frame(x = c(1,1,2),
                  z = c('a', 'b', 'c'))

# specify "x"
df1 %>% left_join(df2, by = "x") # get all possible


# ---- semi_join(), anti_join() ----------

# flights with NO matching plane
flights %>%  anti_join(planes, by="tailnum") %>% # many
        dplyr::count(tailnum, sort=TRUE)


# anther way:
flights %>%  anti_join(planes, by="tailnum") %>% # many
        group_by(tailnum) %>%
        summarize(count = n()) %>%
        arrange(desc(count))

# ---- study, WHEN needed ----------