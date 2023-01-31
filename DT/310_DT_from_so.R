
library(data.table)
 
create_dt  <- function() {
df = structure(list(
  id = 1:2,
  var = c(3L, 9L),
  col1_x = c("[(1,2,3)]", "[(100,90,80,70,60,50,40,30,20)]"), 
  col2_x = c("[(2,4,6)]", "[(100,50,25,12,6,3,1,1,1)]")), 
  class = "data.frame", 
  row.names = c(NA, -2L)
)

  data.table(df)
}

if (F) {
## ----------------------------------LEGACY----------------------
df  = df %>%
  mutate(across(ends_with("x"),~ gsub("[][()]", "", .)))

x_cols = df  %>% 
  select(ends_with("x")) %>% 
  names()

df  = df %>% 
  rowwise()  %>% 
  mutate(across(all_of(x_cols) ,~  ifelse(var<=4,0,sens.slope(as.numeric(unlist(strsplit(., ','))))$estimates[[1]]),.)) %>%
  ungroup()

## --------------------------------------------------------
  }

dt  <- create_dt()

the_cols=grep(pattern="_x$", x=names(dt), value=TRUE )
 

# use specific columns
dt[
, .SD
, .SDcols = the_cols
]

dt[
, .SD
, .SDcols = patterns('_x$')
]

dt  <- create_dt()
dt


# Works
clean_up  <- function(e) gsub(pattern='[][()]', "", e)
dt[,  .(clean_up(col1_x))]


# --PROBLEM------------------------------------------------------
dt[,  .(lapply(.SD, clean_up)), .SDcols=patterns('_x$')]
dt

# BINGO
dt[,  lapply(.SD, clean_up), .SDcols=patterns('_x$')]
dt

# This is IT !
the_cols=grep(pattern="_x$", x=names(dt), value=TRUE )
dt[,  (the_cols) := lapply(.SD, clean_up), .SDcols=the_cols][]

# not quite
dt[,  c(id, var, lapply(.SD, clean_up)), .SDcols=patterns('_x$')]



unlist(base::strsplit("2,4,6",  ","))
dt[
   .(x = gsub("[][()]", "", col1_x))]

