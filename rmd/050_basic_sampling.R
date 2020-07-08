---
title: "050A_basic_samping"
output: 
  html_document: 
    highlight: pygments
    theme: cerulean
    toc: yes
editor_options: 
  chunk_output_type: console
---

```
# above turns off md
### Basic sampling, percentile, quartile
### source: Rafal Chapter 14: https://rafalab.github.io/dsbook/probability.html#discrete-probability
			
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)

#### 0010_rep()
# return vector of 5s,   3 times
rep(x=5,times = 3)  # 5 5 5	

#### 0020_seq()
seq(from = 1, to = 10, by=0.1)

x <- seq(1:10)
x
rep(x, 3) # 1...10 1 ...10  1...10

#### 0030_sample()
sample(x=c(0,1), size= 7, replace=TRUE)

sample(x=c("blue","red"), size=20, replace=TRUE, prob=c(0.8,0.2))

#### 0040_matrix()
m <- matrix(data=1:100, nrow=25) # fills 1st column, then second ...
m

# 7 or 11
sample(1:6,2)

# game:  roll 2 dice, 7 or 11?
# construct matrix of 2 cols, so simulate throwing 2 die, 50x.
B  <- 50  # experiments (rows)
n  <- 2   # per die experiment

s <- sample(1:6,B*n, replace=TRUE) # returns vector
m <- matrix(s, nrow= B, ncol=n)
m

#### 0050_from_norm
df <- data.frame(matrix(rnorm(1000), ncol =10))
head(df)	

#### 0060_coin_flip_running_avg
# 1/n converges slowly!
size <- 100000
t <- tibble(x=sample(x=c(1,0),size=size, replace = TRUE),
			run_avg = dplyr::cummean(x)
			) %>% 
	mutate(line = 1:size)

t %>% head()

t$run_avg %>% tail()
t %>% ggplot(aes(x=line, y=run_avg)) +
	geom_point()
	

# create 'urn' with 5 balls
beads <- rep(c("red", "blue"), times = c(2,3))
beads

# pick sample (of 1)
event <- sample(beads,size=1)
event

# many events
set.seed(2012)
B <- 10000
events <- replicate(B,sample(beads,size=1))
table(events)  #  5988 blue, 4012 blue
t <- tibble(events)
	
# shortcut...
events1 <- sample(beads, size = B, replace = TRUE)
table(events1)  # 5988, 4012

x <- rnorm(10000,0,1)
mean(x <= 0)  # cute,  returns area, percentile

