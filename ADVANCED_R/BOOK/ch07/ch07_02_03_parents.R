library(rlang)

## create new env, child of current env
rlang::env()
ls()


## parent is empty_env; child is e1
e1 <- rlang::env(empty_env(), d = 4, e = 5)

e2 <- rlang::env(e1, a = 1)

library(DiagrammeR)
DiagrammeR::grViz("
  digraph rmarkdown {
	empty_env -> e1 -> e2
  }
  ", height = 600)
