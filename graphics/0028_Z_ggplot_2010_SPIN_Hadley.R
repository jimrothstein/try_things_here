---
TAGS:  ggplot, diamonds
---
# 029_SPIN_Hadley_ggplot.R

# ---- 001 Intro ggplot SPIN----
# Using the SPIN version of Hadley's "Elegant Graphics",  NOT 2015



library(tidyverse)

# ---- Chapter 01 ----
# ---- Chapter 02 ----
# ---- 02.2 -----
names(diamonds)
set.seed(1410) # Make the sample reproducible
nrow(diamonds)  # 53,940

# from 53940 numbers, choose 100
dsmall <- diamonds[sample(nrow(diamonds), 100), ]

# note outliers!
g <- ggplot(diamonds, aes(x=carat, y=price)) # carat, wt,  is continuous

g + geom_point()  # slow!

# overplotting!  'fix' with alpha
g + geom_point(alpha = I(1/100))  # I means calculate | manual

# looks exponential, so take log
# yep, now looks more linear
g <- ggplot(diamonds, aes(x=log(carat), y=log(price)))
g + geom_point()

# Volume vs carat(wt) very linear
g <- ggplot(diamonds, aes(x= carat, y=x*y*z)) 
g + geom_point()

# ---- 02.2 ----
# ---- (aside) quick count ----

str(diamonds)
diamonds %>% count(cut)
# -----------------

# ---- 02.4 ----

g <- ggplot(dsmall, aes(x=carat, y=price, color=color))
g + geom_point()

g <- ggplot(dsmall, aes(x=carat, y=price, shape=cut))
g + geom_point()

# ---- 02.5 ----


# ---- Chapter 05 ----
# ---- 05.3 ----
df <- data_frame(x=c(3,1,5),
                 y=c(2,4,6),
                 label=c('a','b','c'))

p <- ggplot(df, aes(x,y,label=label)) + xlab(NULL) + ylab(NULL)

p + geom_point() +  ggtitle("geom_point")
p + geom_bar(stat="identity") +  ggtitle("geom_bar(\"identity\")")
p + geom_line()         + ggtitle("geom_line") 
p + geom_area(fill="green")         + ggtitle("geom_area")
p + geom_path()         + ggtitle("geom_path")
p + geom_text()         + ggtitle("geom_text")  # prints labels
p + geom_tile(fill="blue", alpha =0.2)         + 
        ggtitle("geom_tile") +
        geom_text()
 
