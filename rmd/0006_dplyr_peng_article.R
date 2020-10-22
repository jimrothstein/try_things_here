
# ---- Tags -----------------------
# devtools, tibble, boxplot, 
library(tidyverse)
library(devtools) 
# devtools::
install_github("clauswilke/ggjoy")
dat
?ggjoy

dat <- data.frame(group=c("A","B","C","D"),value=rnorm(2000))
row.names(dat)          # character vector, row #, "1", "2" etc
dat <- tibble::as.tibble(dat)
row.names(dat)          # hmmmm, seems same as above

has_rownames(dat)       # F

dat %>% filter(group %in% c("A","C","D","A")) %>% 
        ggplot(aes(value)) + 
        geom_histogram(binwidth = 0.5, color="black") +
        facet_grid(.~group)

# ---- boxplot, ordered by median ---------
# stats::reorder (x (usually factor), 
#                 X = numeric, 
#                 FUN = median) - 1st arg is factor, 2nd arg is numeric, 3rd is function 

#       applied to each group

dat %>% mutate(group = reorder(dat$group, dat$value, FUN = median)) %>% 
        ggplot(aes(group, value)) + geom_boxplot()

# ----
# return to dat, tibble:   FIND way without REORDER
dat <- data.frame(group=c("A","B","C","D"),value=rnorm(2000))
dat <- tibble::as.tibble(dat)
dim(dat) # 2000 x 2 (group, value)

g_by <- dat %>% group_by(group)

# no need this stuff
g_by %>% arrange(group)  # sorts by group
g_by %>% summarize(med = median(value)) %>%
        ggplot(aes(group,med)) + geom_boxplot()
######################
# boxplot!
g_by %>% ggplot(aes(group, value)) + geom_boxplot()
