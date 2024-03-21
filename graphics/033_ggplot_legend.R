library(ggplot2)

data <- data.frame("1" = c(1, 3, 6, 4), "2" = c(2, 9, 2, 8))
colnames(data) <- paste0("", c(1, 2))
data

power_1 <- factor(c(0, 0.25, 0.33, "Period"))
power_1

density_vs_power <- ggplot(data = as.data.frame(data))


# Loop to add geom_line layers for each column
for (i in 1:2) {
  density_vs_power <- density_vs_power +
    geom_line(aes(x = power_1, y = !!sym(as.character(i)), group = 1, color = as.character(i))) +
    geom_point(shape = i, aes(x = power_1, y = !!sym(as.character(i)), color = as.character(i)))
}

density_vs_power <- density_vs_power +
  scale_y_continuous(trans = "log10") +
  theme_classic()


density_vs_power

# Simple example
library(ggplot2)
ChickWeight


p1 <- ggplot(ChickWeight, aes(x=Time, y=weight, colour=Diet, group=Chick)) +
  geom_line() +
  ggtitle("Growth curve for individual chicks")
p1
