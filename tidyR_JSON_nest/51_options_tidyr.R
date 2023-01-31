# file <- "0100_options_tidyr.R"
#
#
#   PURPOSE:  explore options(), a list of lists,  using tidy:: purrr
#
#
library(tidyr)
library(listviewer)

# options() (returns <list>)
##  list of approx 87 x 
l  <- options()
length(l)  # ~85
str(l)

##  observe:  not all are atomic objects
  listviewer::jsonedit(l)

##  fails, not all elements of l are vector
tryCatch( t  <- as_tibble(l),
  error = function(e) { cat("ERROR: ", "\n"); print(e)}
  )



##  remove any `functions`, language objects
  l2  <- purrr::discard(l, ~is_function(.x))
  l2
  l3   <- purrr::discard(l2, ~(typeof(.x) == "language"))
  length(l3)  #80

## now rectangularize,  l is named list (check l[1])
  l  <- l3
  t <- tibble(name = names(l), values = l)
  dim(t)   # 80 x 2
  t


##  BEGIN HERE

map(t$values, ~typeof(pluck(1)))
t$typeof  <- typeof(pluck(t$values, 1)) 
head(t)

# Problem, options()[[5]] is 'closure' and not a vector, list.
t %>% tidyr::unchop(values)

options() %>% dplyr::filter(rlang::is_list(values))


typeof(options()[[5]])
t %>% unchop(values)


typeof(pluck(t,2,1))
typeof(pluck(t,2,2))
typeof(pluck(t,2,5))
pluck(t,2,5)
pluck(t,2,10, 1)
pluck(t,2,10, 1)

#### TODO
t %>% tidyr::unnest_wider(options)
tidyr::unnest_auto(t, options)

#### another way
l  <- options()
names(l) #88

#### find element of vector
l["warning.length"]
l["pdfviewer"]	  # /usr/bin/xdg-open
l["keep.source"]  # TRUE
l["browser"]	 # croutonurlhandler


l <- options() %>% 
  list() %>% 
  tibble() %>% 
  unnest_longer(1,indices_to = "option",values_to = "value")
l
options()
# list  -> nested tibble?
t  <- tibble::enframe(options())
head(t)

