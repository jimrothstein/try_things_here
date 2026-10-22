## 200_ggplot_build.R

library(ggplot2)
colours <- list(~class, ~drv, ~fl)

# plot is just base plot()
graphics::plot
?graphics::plot

# Doesn't seem to do anything!
for (colour in colours) {
  ggplot(mpg, aes_(~ displ, ~ hwy, colour = colour)) +
    geom_point()
}

# S3
# 3 graphs, 1 for each choice of colours (and groups by this choice)
# Works when we explicitly print the plots
for (colour in colours) {
  print(ggplot(mpg, aes_(~ displ, ~ hwy, colour = colour)) +
    geom_point())
}


colours
colour = colours[[1]]
colour
g =   ggplot(mpg, aes_(~ displ, ~ hwy, colour = colour)) +
    geom_point()
 g

print(g)
# g is complex object !
typeof(g)
str(g)
