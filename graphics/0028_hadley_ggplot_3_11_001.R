---
TAGS:  
---
#hadley_ggplot_3_11_001.R

# line segments (bottom) 
library(ggplot2)

# ---- 001-histogram ----
ggplot(diamonds, aes(depth)) +
        geom_histogram(binwidth=0.1) + 
        xlim(55, 70)

## build piece by piece
    g <- ggplot(diamonds, aes(depth)) 
    g <- g + geom_histogram(binwidth = 0.1)
    g <- g + xlim(55,70)
    g


caption <-"caption"
g+ annotate("text" , label = caption,
             hjust = 0, vjust = 1, size = 4)

# ---- 4.11 Adding complexity ToDo(STUDY) ----
# 2 layers, point and smooth (think on top of each other)
ggplot(mpg, aes(displ, hwy)) +
        geom_point() +
        geom_smooth() +
        facet_wrap(~year)

# ---- 5.1  Adding layer ----
p <- ggplot(mpg, aes(displ, hwy))  # data, but no layer, presentation
p

p+ geom_point() # show graph
# ========================
# geom_point() is just shortcut to adding a layer:
p + layer(
        mapping = NULL,
        data = NULL,
        geom = "point", geom_params = list(),  # I get errors
        stat = "identity", stat_params = list(),
        position = "identity"
)
# ======================== 
# 3 dataset in graph
# create grid, from mpg
mod <- loess(hwy ~ displ, data = mpg)
grid <- data_frame(displ = seq(min(mpg$displ), max(mpg$displ), length = 50))
grid$hwy <- predict(mod, newdata = grid)
grid

# find outliers
std_resid <- resid(mod) / mod$s
outlier <- filter(mpg, abs(std_resid) > 2)
outlier

# graph

g<- ggplot(mpg, aes(displ, hwy)) +
        geom_point() 
g
g1 <- g +
        geom_line(data = grid, 
                  mapping=aes( colour = "yellow"), 
                  colour="blue",  
                  size = 1.5)
g1


# add labels, no new data points
g2 <- g1 + 
        geom_text(data = outlier, aes( label = paste0(model,class), vjust=1,
                                       hjust=1,
                                       fontface="bold"), 
                  color="red", size=3)
g2

# ---- 5.3.1 exercises ----
library(dplyr)
class <- mpg %>%
        group_by(class) %>%
        summarise(n = n(), hwy = mean(hwy))

# PLOT 1, 
#   MAPs 2 discrete variables: size and color to fix values (not data)
#   ie creates a group, of 1 value
# see legend
g<- ggplot(data=class, mapping=aes(x=class,y=hwy, 
                                   size=5, color="darkblue"))
g

g1<-g + geom_point()
g1

# 
# PLOT 2 , SET size and color to fixed constants
h <- ggplot(data=class, mapping=aes(x=class, y=hwy ))

# SET size and color to constatns, NOT MAP  (works)
#    and not group
h1 <- h + geom_point(size= 5,
                     color="red")
h1
# Add layer with all the
h2 <- h1 + geom_point(data=mpg, 
                      mapping=aes(x=class, 
                                  y=hwy),
                      size = 1,
                      color="black")
h2


# ---- 5.4.1 STUDY, aes() ----
# 2 layers, where aes() changes things!

# ----
# PLOT 1
# class is chr, not factor
g1<-ggplot(mpg, aes(displ, hwy, colour = class)) +
        geom_point() 
g1

# se = FALSE (no confidence intervals)
# smooths each class individually
g2<- g1 +
        geom_smooth(method = "lm", se = FALSE) +
        theme(legend.position = "none")
g2

# =====
# VS
# PLOT2
# h1 same as g1
h1<-ggplot(mpg, aes(displ, hwy)) +
        geom_point(aes(colour = class))
h1
# smmoths once, includes all data
h2<-h1 +
        geom_smooth(method = "lm", se = FALSE) +
        theme(legend.position = "none")
h2

# ---- 5.4.2 explanation (map vs set)
# set, to constant, all blue points
ggplot(mpg, aes(cty, hwy)) +
        geom_point(colour = "darkblue")

# map, creates new DISCRETE 'variable', colour, 
# which - in theory -  can vary. So gets a discrete scale.
ggplot(mpg, aes(cty, hwy)) +
        geom_point(aes(colour = "darkblue")) +
        labs(colour = "Label this scale")
        

# to fix, .....
ggplot(mpg, aes(cty, hwy)) +
        geom_point(aes(colour = "darkblue")) +
        scale_colour_identity()  # override scale?

# trick, 2 layers, want to compare
ggplot(mpg, aes(displ, hwy)) +
        geom_point() +
        geom_smooth(aes(colour = "loess"), method = "loess", se = FALSE) +
        geom_smooth(aes(colour = "lm"), method = "lm", se = FALSE) +
        labs(colour = "Method")

# ---- 5.4.3 Exercises ----
# PLOT 1
ggplot(mpg) +
        geom_point(aes(mpg$displ, mpg$hwy))

# PLOT 2 (simplified)
ggplot(mpg, aes(x=displ, y=hwy)) +
        geom_point()


# PLOT 1
ggplot() +
        geom_point(mapping = aes(y = hwy, x = cty), data = mpg) +
        geom_smooth(data = mpg, mapping = aes(cty, hwy))
# PLOT 2 (simpified)
ggplot(data=mpg, mapping = aes(x=cty, y=hwy)) +
        geom_point() +
        geom_smooth()

# PLOT 3 (for fun, trick to add layers)
ggplot(data=mpg, mapping = aes(x=cty, y=hwy)) +
        geom_point(aes(color="point")) +
        geom_smooth(aes(color="smooth"))

# PLOT 1
ggplot(diamonds, aes(carat, price)) +
        geom_point(aes(log(brainwt), log(bodywt)), data = msleep)
str(msleep) # brainwt, bodywt both num

# PLOT 2

ggplot(diamonds, aes(carat, price)) + geom_point() +
        geom_point(aes(log(brainwt), log(bodywt)), data = msleep)
str(msleep) # brainwt, bodywt both num

# PLOT 3 (separae)
ggplot(diamonds, aes(carat, price)) + geom_point() 
ggplot(aes(log(brainwt), log(bodywt)), data = msleep) + geom_point()
str(msleep) # brainwt, bodywt both num

# ---------------------------------------
##  Arrows
# ---------------------------------------
NAME <- c("A", "A", "B", "B", "C", "C")
 YEAR <- c(2016, 2011, 2016, 2011, 2016, 2011)
 YEAR <- as.factor(YEAR)
 VALUE <- c(1, 4, 1, 5, 2, 8)
 DATA <- data.frame(NAME, YEAR, VALUE)
 DATA

ggplot(DATA, aes(x=VALUE, y=NAME)) + 
  geom_point(size=5, aes(colour=YEAR)) +
  geom_line(arrow = arrow(length=unit(0.30,"cm"), ends="first", type = "closed"))

# ---------------------------------------
#  Multiple line segments: 
# ---------------------------------------
# http://ms.mcmaster.ca/~bolker/misc/ggplot2-book.pdf
# segmens and color
#
#   # background points
    data <- data.frame(x = 1:6,                      # Create example data frame
                   y = c(5, 3, 4, 8, 2, 3))
#   base plot
    ggp <- ggplot(data, aes(x, y)) +                 # Create ggplot2 plot without lines & curves
    geom_point()
    ggp                                              # Draw ggplot2 plot

    # segments

    # my segments (horizontal)
    data_lines <- data.frame(x = c(2,2,2),                # Create data for multiple segments
                            y = c(2,3,4),
                            xend = c(4,4,4),
                            yend = c(2,3,4),
                            col = paste0("line_", letters[1:3]))
    data_lines       

ggp +                                            # Draw multiple line segments
  geom_segment(data = data_lines,
               aes(x = x,
                   y = y,
                   xend = xend,
                   yend = yend,
                   col = col,
                   arrow = rep(arrow(), 3  )))

