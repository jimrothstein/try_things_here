#036_basic_t_test.R

# Recent NY Times article claimed the number of non-US born "Genius" awards (as defined by 
#  ...... Foundation) greatly exceeds the expected number, based on proportion of 
# US population that is non-US born.   (The award is only open to US residents or
# citizens.)

# Using the information in the article, I want to get check this (avoiding introducing
# any political arguments).


# The proportion of non-US born people in the US is 13 %, from 2010 US census.  
# This is population proportion or p0 = 0.13.


# Out of N=965 "genius" awards given since inception of the foundation,  209 or
# 21.7% were born outside the US.   So p_hat = 0.217


# Is this significant?


# Hypothesis is H0 that p_hat = p0   vs   H1: p_hat != p0

# For a proportion,  Standard Error is given by 
# SE = sqrt (p0(1-p0)/n)

# and the Z-test is   (p_hat -  p0) / SE

N <- 965
p0 <- 0.13
p_hat <- 209/N  # 0.217

SE <- sqrt(p0*(1-p0)/N)    # 0.011

#
t <- p_hat/SE  # 20.006

# So   reject H0,   so clearly can be RANDOM group.


# Method 2
N <- 965
# but 
US <- 350 * 10^6
p0 <- N/US  # 2.77 * 10^-6

p_hat <- 209/(.13 * US) # 4.59 * 10^-6

d <- p_hat - p0  # 1.84 * 10^-6

SE <- sqrt(p0*(1-p0)/N)  # 5.35 * 10 ^-5

t <- d/SE  # 0.034
#####  Binomial #####

# pmf - binomial, x=success, size=throws

dbinom(x=0,size=2, prob=0.5) # n=2, x=0  prob = 0.25
dbinom(x=1, size =2 , prob=0.5) # n=2, x=1 # 0.5
sum(dbinom(x=0:2,size=2, prob=0.5)) # SUM = 1

