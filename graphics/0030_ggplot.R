

##  problem with round?   scale_y_continuous?
library(ggplot2)
mtcars

ggplot(mtcars, aes(drat,mpg)) +
        geom_point()

mtcars$drat
data$y = mtcars$drat
round(data$y, digits=1)
br2 = round(max(data$y), digits=1)

  br1 <- 0
  br2 <- round(max(data$y), digits = -1) # to round to the nearest tenand then put
br2
scale_y_continuous(limits = c(br1, br2, breaks = seq(br1, br2, by = 5 ))

seq(0,4.9, by=.5)

