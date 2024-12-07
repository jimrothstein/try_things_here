#   05_pivot_longer_wider_BASIC.R
#---
#TAGS:  pivot, nest, tidyr
#---
# ------------------------------------
# Simple Examples of the Messy Data
#     NOTES
# ------------------------------------
# SEE r4ds Chapter 12
# SEE https://tidyr.tidyverse.org/articles/tidy-data.html
- non-tidy
- tidy
- pivot_longer:  normalizes when repetitve columns (wk1 wk2 ...)
- pivot_wider
- separate (one combo column, split into two)
#
# -----------------------------
# Libraries & setup sample data
# -----------------------------
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
 #OR

tribble(
  ~assessment, ~Billy, ~Suzy, ~Lionel, ~Jenny,
  "quiz1",     NA,     "F",   "B",     "A",
  "quiz2",     "D",    NA,    "C",     "A",
  "test1",     "C",    NA,    "B",     "B"
  )

# ----------------------------------------------
# The PROBLEM:  column heads contain variables
# ----------------------------------------------
# OR  Tidy (normalize), where columns and rows HAVE MEANING (semantics)
#
str(classroom)
classroom |> head()
# # A tibble: 4 × 4
#   name   quiz1 quiz2 test1
#   <chr>  <chr> <chr> <chr>
# 1 Billy  <NA>  D     C
# 2 Suzy   F     <NA>  <NA>
# 3 Lionel B     C     B
# 4 Jenny  A     A     B


# ---------------------------
#   USE tidyr::pivot_longer
# ---------------------------

##  GOAL: To normalize:   key index becomes (in effect) all combos name, quizes (assessment  )
# --------
# names*
# assessment*
# grade
# --------
(classroom2 <- classroom %>%
  tidyr::pivot_longer(cols = quiz1:test1,
    names_to = "assessment",
    values_to = "grade") %>%
  arrange(name, assessment))

##  inverse !  returns to orginal
(classroom3  <- classroom  %>%  unnest_longer(name))



