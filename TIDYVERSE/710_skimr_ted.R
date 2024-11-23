library(skimr)
cereals <- read.csv("data/cereal.csv")
glimpse(cereals)


z1 <- cereals |> janitor::clean_names()
identical(z1, cereals)

za <- z1 |> mutate(manufacturer = mfr, mfr = NULL)

z2 <- za |> mutate(shelf = factor(shelf, ordered = TRUE))
attributes(z2$shelf)
z2$shelf
glimpse(z2)

z3 <- z2 |> mutate(across(c("manufacturer", "type"), as.factor))
glimpse(z3)


skim_output <- skimr::skim(z3)
summary(skim_output)

glimpse(skim_output)


skimr::yank(skim_output, "character")
skimr::yank(skim_output, "factor")
skimr::yank(skim_output, "numeric")
