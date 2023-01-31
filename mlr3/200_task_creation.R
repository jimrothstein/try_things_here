data("mtcars", package = "datasets")
data = mtcars[, 1:3]
str(data)

library("mlr3")

task_mtcars = as_task_regr(data, target = "mpg", id = "cars")
print(task_mtcars)


library("mlr3viz")
autoplot(task_mtcars, type = "pairs")
