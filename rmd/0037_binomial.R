#037_binonial.R

######################
#  Use to explain code
#
#
#
#  End of explain..
######################

## for full-line comments
# ---- 000-big sections ----------- for big sections

# library(tidyverse)
library(tibble)
library(jimTools)

#####  Binomial #####
dbinom(x=1:5,size=400, prob=0.2)


# pmf(density) - binomial, prob of x=# success, size=throws
# usu written as choose(n,x) (p^n) (1-p)^(k-n)
# x may be vector

dbinom(x=0,size=2, prob=0.5) # n=2, x=0  prob = 0.25
dbinom(x=1, size =2 , prob=0.5) # n=2, x=1 # 0.5

#  size = 1000, prob=.5,   number of heads =?
dbinom(x=1, size=1000, prob=0.5)
sum(dbinom(x=0:2,size=2, prob=0.5)) # SUM = 1

sum(dbinom(x=1:5, size=400, prob=.2))
sum(dbinom(x=1:400, size=400, prob= .2))

######   Pr (# of successes X <= value x)
pbinom(400, prob=0.2, size=400)				# 1, no suprise
pbinom(80, prob=0.2, size=400)				# 53.0% will be less than 80
pbinom(100, prob=0.2, size=400)				# 99.3% will be less or = 100 success

######	Pr (# of successes X = value x)
dbinom (80, prob=0.2, size=400)				# 0.05
dbinom (81, prob=0.2, size=400)				# 0.05
dbinom (90, prob=0.2, size=400)				# 0.02

# or
sum(dbinom(60:100, prob=0.2, size=400))			# 0.99   (99% succcess bet 60, 100)
#####
qbinom( c(0.8), prob=0.2, size=400)			# 87    (80% of successes, 87 or less successes)
##### 002 Plot Binomial pmf, Pr(X = some x) ####
# TODO(jim, add density, ie superimpose normal)
t <- tibble(x = c(0:n), y = dbinom(x, size=10, prob=0.9))

g <- ggplot(t, aes(x,y))
g + geom_histogram(stat="identity", 
                   fill="lightblue") +
        scale_x_continuous(breaks =  c(0,1,2,3,4,5,6,7,8,9,10)) 
                
#### 003 p=0.6, n=20 ####
p <-  0.6
n <- 20
mu <- p * n # 12
mu
sigma <- sqrt(n*p*(1-p)) # 2.19
sigma

# plot (from 002)
t <- tibble(x = c(0:n), y=dbinom(x, size=n, prob=p))

g <- ggplot(t,aes(x,y))
g + geom_histogram(stat="identity", 
                   fill="lightblue") +
        scale_x_continuous(breaks =  c(0:20)) 

#  Find Pr(X <= 10) - exact and by normal approx
sum(dbinom(x= c(0:10),   # 0.05652
           size=20,
           prob=0.6)
    )
# X = 10 exactly
dbinom(x=10, size =20, 0.6)  # 0.117 (exact)
# Normal approx

z_high <- (10 + 0.5 - 12)/sigma
z_low <- (10 -0.5 - 12)/sigma
pnorm(c(z_low,z_high), mean=0, sd =1)

pnorm(z_high, mean=0, sd=1) - pnorm(z_low, mean=0, sd=1)  # 0.120 (approx)
# Normal


# ========
# rbinom
# ========
# sucesses if toss coin 100 times 
set.seed(2020) # 52
x <- rbinom(1, size=100, p=0.5)
x #52

# SAME, but repeat the experiment 40 times
# returns int[] of successes
x <- rbinom(40, size=100, p=0.5)
x # int[40], number of heads each experiment

# of the 40 experiments, how many returned > 55 heads?
table(x > 55) # 10	;
table(x > 57) # 2	;
table(x > 60) # 0
# =================




# ----Series of Bernoulli Trials			----

# int[10]
(rbinom(10,size=100,prob=0.5))		# throw dice 100 times, count heads (repeat 10)

# instead:
x  <- sample(x =  c("H","T"),
		size = 1000,
		replace = TRUE,
		prob = c(0.5,0.5)
		)
x
what_is_it(x)
y  <- str_c(x, collapse="")		# collapse
# [1] "TTTHTHTTTHTHHTTHTTTTHHHTTTTHHTTHTTTTHTHTTHHHHHTHTHTHHHTTHHTHTHHHHTHTHTHHHTHTHTHTHHTTTTTTTTTHHTHHHHHHTTHHHTTHHHHHTHTHHHTTHTTTHTTTTHTTTTHTHTHHHHHHHTHHTTHHTTTHTTHTHTTTHTTTTTTTTTTHHTTTHTHHHTTHTHTHTTTHHTHHHTHTTHTHTTHTTHTTTTTHHHHTTHHHTTTTHTHTTTTHHTTHTTTHTHHHTHTTHHTHTTTHTHHHTTHHTHHTTHHHHTTTHHTTHTTHTHHTHHHHHHHHTHTHHHHHTTHTHTHHTTTHTTTHTTHHHHTTTTHTTTHHHTHHTHTTHHTHTHTHHHHHHTHHHHHTTHTHHTTHHTTTHTTHHHHTHTTTHTTTTHHTHHTHTHTTTHHTTHTTTHTHTHTTHHHTHHTHTTTTHTTTHTTTHTHHTTTHTTTTHHHTTHHHHHTHHHHTHHHHHTTHTTTTHHTTTTTTHTHHTTHHHHTHTTHTTTHHHHTHTTHTTHTTTHTTTTTTTHHTTTTTHHHHHTTTHTHHHTTHTHTTTHTTTHHHTTHHHHHHTHHTHTTTTHHHTHHTHTTHHTHHTTTTTTTTHTTTHHTTTTTHHTTTHTHHTHHHHHTHTHTHTHTHHTTTHHHTHHHTTHTTTTHHTHHHTTTHTTTHTTHTHHTTHHHHTTTHTHHHTHTTTTHHHHTTHTTTHTHTHTHTHTTHHTHHHHTTHTHTTTHHTTHHTTHHHHTTHTTTTTHTTTHTTHTTTHTTTHHHTHHTTHTTHTHHTTTHHTHHTTHTTTHHTHHTTHHTHHTTTHTHTHTHHHHHHHHTTTHHHHHHTHTHHTHHTTTTTTTTTHHTTHTTHHTHTHTTTTHTTTTTHHHHHHTHTTTTTHHHHTHTHTTTHTHTHHTTTTHHHHTHTHTHTHHTHTHTHHHTTTHHHTTTTHTTHHTHTTHTTTHHHHHTHTTTHTHTTHHTTTHTTTHHTTHTHTHHHHTT"
# FOR REAL
set.seed(1492)
nExp = 100
nThrows = 1000 # IN EACH TRIAL
X  <- sample(x = c(1,0),
		size= nThrows* nExp,# NUMBER THROWS
		replace= TRUE,
		prob= c(0.5,0.5)
		)
#X # VECTOR_DBL, ATOMIC
what_is_it(x)	# 100,000
#M <- AS.MATRIX(X, NROW = NtHROWs, ncol=nExp, byrow=TRUE)
## matrix fill first by column, then next row
m <- matrix(rbinom(n=nExp*nThrows, 
		   size=1,
		   0.5), 
	    ncol=nExp) # n total number of random
m[1,1]
## test
m1 <- matrix (rbinom(n=nExp*nThrows,size=1,
		     0.5),
	      nrow=nThrows)

mean(colSums(m))
sd(colSums(m))

sqrt(250)  # 15.8

plot(colSums(m))
hist(colSums(m))

head(m)
dim(m)

## What does CI (Confidence Interval)  mean?
#  ============================================
## Suppose want to find percentage of students (many) with tatoos
##
## How ?   SAMPLE
p = 0.4  # (usually do not know)
n = 75   # students, sample size
## FACT
## se_bar = sqrt( p_bar * (1 - p_bar)/n)
##

## Take a Sample  (ie string of yes/no, 1,0
r  <- sample(x = 0:1,
             size = 75,
             replace = TRUE, 
             prob = c(0.6, 0.4))
r
sum(r) #31
p_bar = sum(r)/n
p_bar   # 0.413

## And the 95% CI?
se_bar = sqrt( p_bar * (1 - p_bar)/n)
se_bar   # 0.0569
L  <- p_bar - 1.96*se_bar
U  <- p_bar + 1.96*se_bar
cat("p_bar = ", p_bar, "\n", "CI = ", "(", L, ", ", U, ")",  "\n")
contains_TRUE =  p_bar >= L   && p_bar <= U
contains_TRUE

#####   OR 
# ===========================================
## What does 95% confident actually mean??
## rbinom (n=1, size = 75, prob= 0.4)retrun string of yes/no, 1,0  (size # trials)
## To me:  n=1 means 1 SAMPLE, 
## size=throws in 1 SAMPLE, 
## return is # successes in 1 SAMPLE
##
## n =2 means, return will be 2 values, one for each sample
##
###  FUNCTION
###
 N=75
t  <- tibble::tibble()
one_sample  <- function(DUMMY = null) {  # 1 sample

    prob = 0.4
    p_bar  <- rbinom(n=1, size=75, prob = prob)/N
    ## And the range?
    se_bar = sqrt( p_bar * (1 - p_bar)/N)
    L  <- p_bar - 1.96*se_bar
    U  <- p_bar + 1.96*se_bar
    # cat("p_bar = ", p_bar, "\n", "CI = ", "(", L, ", ", U, ")",  "\n")
    contains_TRUE =  (L < prob)   && ( prob < U )
    new  <- tibble::tibble(p_bar = p_bar, L=L, U=U, contains_TRUE = contains_TRUE)
    t <<- rbind(t, new)
    invisible()
}


ans  <- lapply(0:99, one_sample)

# view
t
print(t, n=100)

# to see only FALSE   
t[!t$contains_TRUE,]
t[!t$contains_TRUE,]

# order
print(t[order(-t$L),], n=100)

###
f  <- function(x) invisible(print("hi"))
f()
r  <- lapply(0:1, f)


#### ARGH!  need dummy variable
f  <- function(dummy) {print("hi")}

l  <-   lapply (1:2, f)
