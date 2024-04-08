---
---
library(tidyverse)
library(jimPackage)

t1 <- tibble(readLines("words.txt"))	# t1 is tibble

t <- as_tibble(readLines("words.txt"))	# t is tibble
t$length <-as.integer(nchar(t$value))
#freq <- as_tibble(table(t$length))
hist(t$length)
 write_tsv(t,"histogram.tsv")

 
 
 source("044_make_histogram.R")
 
