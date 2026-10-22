# https://www.r-bloggers.com/2019/06/a-gentle-introduction-to-tidymodels/
library(tidymodels)

# split ----

iris_split <- initial_split(iris, prop = 0.6)
iris_split
## <90/60/150>


iris_split %>%
  training() %>%
  glimpse()


# 4 predcitor, 1 outcome; not cleaning, but prep data (scale, remove highly correlated predictors, etc.) ----

iris_recipe <- training(iris_split) %>%
  recipe(Species ~.) %>%
  step_corr(all_predictors()) %>%
  step_center(all_predictors(), -all_outcomes()) %>%
  step_scale(all_predictors(), -all_outcomes()) %>%
  prep()

iris_recipe

# repeat with testing split:w

iris_testing <- iris_recipe %>%
  bake(testing(iris_split)) 
iris_training <- juice(iris_recipe)

glimpse(iris_training)
