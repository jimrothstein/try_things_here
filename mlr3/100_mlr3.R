
#	Quickstart from mlr3book#
library("mlr3")
task = tsk("iris")
learner = lrn("classif.rpart")

# 150 rows
length(iris[,1])

# train a model of this learner for a subset of the task
learner$train(task, row_ids = 1:120)

# this is what the decision tree looks like
learner$model
