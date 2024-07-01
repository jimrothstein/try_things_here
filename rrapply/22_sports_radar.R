library(jsonlite)
library(magrittr)
library(tidyr)
library(listviewer)

sr_raw <- readRDS(url("https://github.com/guga31bb/sport_radar/blob/master/data/participation/c2b24b1a-98c5-465c-8f83-b82e746b4fcf.rds?raw=true"))

listviewer::jsonedit(sr_raw)

# of 17 items from root, he wants only 2 siblings (summary, plays)   which are lists
# All the same ...
sr_raw %>%
  magrittr::extract(c("summary", "plays")) %>%
  tibble()
sr_raw %>%
  `[`(c("summary", "plays")) %>%
  tibble() # functional form
sr_raw %>%
  `[`(c("summary", "plays")) %>%
  tibble() %>%
  jsonedit() # functional form

##  individually
sr_raw$summary %>% tibble()
sr_raw$plays %>% tibble()

##  another way
sr2 <- sr_raw[c("summary", "plays")] %>% tibble()
sr2

## seems doing too much for free. (ie transposes)
plays <- sr_raw$plays %>% tibble()
plays
