# Messy Data -  The Problem

# SEE https://tidyr.tidyverse.org/articles/tidy-data.html
- non-tidy
- tidy
- pivot_longer
- pivot_wider
- separate (one combo column, split into two)
# 
library(dplyr)
library(tibble)
library(tidyr)
library(tibble)

# ------- Same data represented by different DATA STRUCTURES ---------
classroom <- tribble(
  ~name,    ~quiz1, ~quiz2, ~test1,
  "Billy",  NA,     "D",    "C",
  "Suzy",   "F",    NA,     NA,
  "Lionel", "B",    "C",    "B",
  "Jenny",  "A",    "A",    "B"
  )

# OR

tribble(
  ~assessment, ~Billy, ~Suzy, ~Lionel, ~Jenny,
  "quiz1",     NA,     "F",   "B",     "A",
  "quiz2",     "D",    NA,    "C",     "A",
  "test1",     "C",    NA,    "B",     "B"
  )

# ------------------------- Normalize---------------------

# OR  Tidy (normalize), where columns and rows HAVE MEANING (semantics)
#
str(classroom)

classroom2 <- classroom %>% 
  tidyr::pivot_longer(cols = quiz1:test1, 
    names_to = "assessment", 
    values_to = "grade") %>% 
  arrange(name, assessment)

# Now Tidy
classroom2


classroom3  <- classroom  %>%  unnest_longer(name)
classroom3

classroom2
classroom2
#> # A tibble: 12 × 3
#>    name   assessment grade
#>    <chr>  <chr>      <chr>
#>  1 Billy  quiz1      NA   
#>  2 Billy  quiz2      D    
#>  3 Billy  test1      C    
#>  4 Jenny  quiz1      A    
#>  5 Jenny  quiz2      A    
#>  6 Jenny  test1      B    
#>  7 Lionel quiz1      B    
#>  8 Lionel quiz2      C    
#>  9 Lionel test1      B    
#> 10 Suzy   quiz1      F    
#> # … with 2 more rowsoolbar$children




# ------------ relig_income----------------------------------
relig_income
str(relig_income)

relig2  <- relig_income %>% 
  tidyr::pivot_longer(cols = 2:11,  # also cols=-religion
  names_to = "income",
  values_to = "freqency") 
relig2
