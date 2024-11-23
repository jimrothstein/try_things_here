df <- data.frame(name = c("a", "b", "b", "c", "c", "c"), count = c(1, 2, 3, 1, 2, 3))
df
library(tidyr)
new <- df %>% nest()
new
new$data
new$data[[1]]
