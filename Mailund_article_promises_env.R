
```{r Mailund}# {{{
Idea:  Treat separately an R expression and the env to evaluate it.
R can NOT manipulate a promise.  See Ch 20, quosures to turn promise into R object.  Before get to Hadley, MAILUND seems clearer
https://mailund.dk/posts/promises-and-lazy-evaluation/
pryr::  note spelling
```
```{r mailund2, echo=TRUE}
# why does this work?
# b/c evaluation is function frame, not calling frame

f <- function(x, y, z = 2 * x) x + z
a <- b <- 1
f(a + b, stop("ARGH!!!"))
```
```{r}
f,g created in Global Env.
create `promises` only; no evaluation
Case I, f is also called from Global env
Case II, f is called when current_env is NOT Global
```

```{r}
library(rlang)
# create in Global
f <- function(x) pryr::promise_info(x)

# Case I
# call f in Global
f(x)   # function env is Global

# Case II
# call f inside a differnt env
g <- function(z) {
	print(current_env())
	print(fn_env(f)) # Global
  f(z)
}
g(x + y)

# f,g
env_names(current_env())
```

```{r}
# promise = expression, env (where called)
# Watch, once evaluate x, promise's  env disappears
# Also, before evaluation, current_env not same as promise env
# Mailmund cont

```
